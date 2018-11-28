#!/bin/bash
echo "Start Prometheus + Grafana + AlertManager"
cd /opt/scripts/

nohup sh alertmanager.sh &
nohup sh prometheus.sh &
nohup sh grafana.sh &
nohup sh exporter.sh &

sleep 1s
netstat -tnlp
echo "Author by: Nolove"
