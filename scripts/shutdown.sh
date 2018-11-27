#!/bin/bash
echo "Stop Prometheus + Grafana + AlertManager + Exporter"
#prometheus=`pidof ./prometheus`
prometheus=`netstat -ntlp | grep 9090 | awk '{print$7}' | cut -d'/' -f1`
kill -9 $prometheus
grafana=`netstat -ntlp | grep 3000 | awk '{print$7}' | cut -d'/' -f1`
kill -9 $grafana
alertmanage=`netstat -ntlp | grep 9093 | awk '{print$7}' | cut -d'/' -f1`
kill -9 $alertmanage
exporter=`netstat -ntlp | grep 9100 | awk '{print$7}' | cut -d'/' -f1`
kill -9 $exporter

#after=`netstat -ntlp`
#echo $after 
echo "Shutdown all service by Nolove"
