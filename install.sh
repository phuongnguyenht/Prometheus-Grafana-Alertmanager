#!/bin/sh
# ***********************
# Author by: PhuongNT
# Link download https://prometheus.io/download/#node_exporter

yum install wget -y 
yum install net-tools -y 
mkdir -p /opt/setup
cd /opt/setup
wget https://github.com/prometheus/prometheus/releases/download/v2.5.0/prometheus-2.5.0.linux-amd64.tar.gz
wget https://github.com/prometheus/alertmanager/releases/download/v0.15.3/alertmanager-0.15.3.linux-amd64.tar.gz
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.3.4.linux-amd64.tar.gz 
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0-rc.0/node_exporter-0.17.0-rc.0.linux-amd64.tar.gz

tar -zxvf prometheus-2.5.0.linux-amd64.tar.gz -C /opt
tar -zxvf alertmanager-0.15.3.linux-amd64.tar.gz -C /opt
tar -zxvf grafana-5.3.4.linux-amd64.tar.gz -C /opt/
tar -zxvf node_exporter-0.17.0-rc.0.linux-amd64.tar.gz -C /opt/

cd /opt/
mv prometheus-2.5.0.linux-amd64 Prometheus
mv alertmanager-0.15.3.linux-amd64 alertmanager
mv grafana-5.3.4 grafana
mv node_exporter-0.17.0-rc.0.linux-amd64 exporter

#Install Percona app for Grafana
cd /opt/grafana/bin/
./grafana-cli plugins install percona-percona-app

# Install nginx 
# Add Nginx Repository
yum install epel-release -y
# Install Nginx
yum install nginx -y 

systemctl start nginx
systemctl enable nginx

# Disable selinux 
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
# Check log 
cat /var/log/audit/audit.log | grep nginx | grep denied 

# Open port if firewalld started
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

# Setup HTTP Basic Authentication
yum install -y httpd-tools