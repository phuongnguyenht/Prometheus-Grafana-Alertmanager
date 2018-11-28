# Configure nginx 

Setup HTTP Basic Authentication
```
Tao user and passord để login nginx
htpasswd -c /etc/nginx/.htpasswd nginx
# In above command we are storing credentials in /etc/nginx/.htpasswd for user nginx.

vi /etc/nginx/nginx.conf
# Under the server section, add auth_basic and auth_basic_user_file directives,
# auth_basic "Private Property";
# auth_basic_user_file /etc/nginx/.htpasswd;
```

# Referent: https://hostpresto.com/community/tutorials/install-and-secure-nginx-on-centos-7/
