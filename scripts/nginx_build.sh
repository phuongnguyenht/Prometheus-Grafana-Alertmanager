#!/usr/bin/env bash

# names of latest versions of each package
export VERSION_NGINX=nginx-1.13.1
export VERSION_MODSECURITY=modsecurity-2.9.2
echo "VERSION_NGINX=nginx-1.13.1" >> ~/.bash_profile
echo "export VERSION_MODSECURITY=modsecurity-2.9.2" >> ~/.bash_profile
source ~/.bash_profile

# ensure that we have the required software to compile our own nginx from internet
yum -y install gcc gcc-c++ make automake autoconf libtool pcre pcre-devel libxml2 libxml2-devel curl curl-devel httpd-devel openssl-devel apr-devel apr-util-devel

ver=`rpm -q --queryformat '%{VERSION}' centos-release`
if [ $ver -eq 7 ]
then
	#install for centos 7
	yum install net-tools -y 
else
	echo "Skip"
fi


#add user and group for nginx
groupadd -r nginx
useradd -r -g nginx -s /sbin/nologin -M nginx

#Download Modsecurity and Nginx 
mkdir -p /opt/build-nginx
cd /opt/build-nginx
wget https://www.modsecurity.org/tarball/2.9.2/modsecurity-2.9.2.tar.gz
wget http://nginx.org/download/nginx-1.13.1.tar.gz

tar xvzf $VERSION_NGINX.tar.gz
tar xvzf $VERSION_MODSECURITY.tar.gz

export BPATH=$(pwd)
chmod +x /usr/local/apr/bin/*

#Build Modsecurity
cd $BPATH/$VERSION_MODSECURITY
./configure --enable-standalone-module --disable-mlogc
make && make install

# build nginx, with various modules included/excluded
cd $BPATH/$VERSION_NGINX
./configure --with-http_ssl_module \
--user=nginx \
--group=nginx \
--prefix=/opt/$VERSION_NGINX \
--with-pcre \
--with-cpu-opt=generic \
--with-http_realip_module \
--with-http_gzip_static_module \
--add-module=../$VERSION_MODSECURITY/nginx/modsecurity/
make && make install

mkdir -p /opt/$VERSION_NGINX/conf/modsecurity
cp $BPATH/$VERSION_MODSECURITY/modsecurity.conf-recommended /opt/$VERSION_NGINX/conf/modsecurity/modsecurity.conf
cp $BPATH/$VERSION_MODSECURITY/unicode.mapping /opt/$VERSION_NGINX/conf/modsecurity/

ln -s /opt/$VERSION_NGINX /opt/nginx
mkdir -p /opt/nginx/conf/conf.d
sed -i "s|SecAuditLog /var/log/modsec_audit.log|SecAuditLog /opt/$VERSION_NGINX/logs/modsec_audit.log|"        /opt/$VERSION_NGINX/conf/modsecurity/modsecurity.conf
sed -i "s|#SecDebugLog /opt/modsecurity/var/log/debug.log|SecDebugLog /opt/$VERSION_NGINX/logs/modsec_debug.log|"        /opt/$VERSION_NGINX/conf/modsecurity/modsecurity.conf
sed -i "s|#SecDebugLogLevel 3|SecDebugLogLevel 0|"        /opt/$VERSION_NGINX/conf/modsecurity/modsecurity.conf
sed -i "s|#SecRuleEngine DetectionOnly|SecRuleEngine On|"        /opt/$VERSION_NGINX/conf/modsecurity/modsecurity.conf

echo "All done."
echo "Script by Nolove"
