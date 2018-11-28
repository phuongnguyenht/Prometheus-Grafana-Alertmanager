# Các bước cài đặt cấu hình Prometheus

1. Chạy file install.sh để cài đặt Prometheus, grafana, alertmanager, node exporter, nginx
2. Cấu hình nginx trong folder nginx
3. Cấu hình Prometheus + tạo folder rules và thêm các rule < xem trong foler Prometheus >
```
Note: Enable firewalld thi không vào được các port của prometheus, grafana ...
IP:9090/consoles or IP/consoles/file_name
[root@prometheus consoles]# ls
index.html.example  node-cpu.html  node-disk.html  node.html  node-overview.html  prometheus.html  prometheus-overview.html

Khi tạo rule xong kiểm tra rule trong folder scripts chạy file bash checkrule.sh và updaterule.sh 
Tham khảo: https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/

Một số rule example
https://petargitnik.github.io/blog/2018/01/04/how-to-write-rules-for-prometheus
https://github.com/prometheus/prometheus/blob/master/docs/configuration/alerting_rules.md	
https://github.com/hocchudong/ghichep-prometheus/blob/master/4.Ket_hop_Prometheus_va_Grafana.md
``` 
4. Cấu hình Grafana
```
Open file /opt/grafana/conf/defaults.ini
# The full public facing url
#root_url = %(protocol)s://%(domain)s:%(http_port)s/
root_url = %(protocol)s://%(domain)s:%(http_port)s/grafana/
#################################### SMTP / Emailing #####################
[smtp]
enabled = true
host = 103.31.126.191:25
user = [account]
# If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
password = [password]
cert_file =
key_file =
skip_verify = true
#skip_verify = false
#from_address = admin@grafana.localhost
from_address = [account]
from_name = Grafana Monitor
ehlo_identity =

Xem log: /opt/grafana/data/log/grafana.log
```
5. Cấu hình Alertmanager
```
Tham khảo file custom.yml </opt/alertmanager>
```
6. Note
```
ten_collector=kieu_metric("ten_metrics","Tên chi tiết metrics",{Các thông tin bổ sung cho metrics})

#Ví dụ:
mysql_seconds_behind_master = Gauge("mysql_slave_seconds_behind_master", "MySQL slave secons behind master",{})

Try use promtool update rules your.rules command,
it will generate a new rules file called your.rules.yml

 http://docs.grafana.org/installation/configuration/#http-port
 alertmanager
 https://medium.com/@abhishekbhardwaj510/alertmanager-integration-in-prometheus-197e03bfabdf
 https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/
 
 rules example 
 https://petargitnik.github.io/blog/2018/01/04/how-to-write-rules-for-prometheus
 https://github.com/prometheus/prometheus/blob/master/docs/configuration/alerting_rules.md	
 https://github.com/hocchudong/ghichep-prometheus/blob/master/4.Ket_hop_Prometheus_va_Grafana.md
 
 firewalld
 https://www.rootusers.com/how-to-use-firewalld-rich-rules-and-zones-for-filtering-and-nat/
 
 ```