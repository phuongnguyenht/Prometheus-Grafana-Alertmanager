#!/bin/bash
echo "Start Prometheus + Grafana + AlertManager"
cd /opt/script/

nohup sh alertmanager.sh &
nohup sh prometheus.sh &
nohup sh grafana.sh &
nohup sh exporter.sh &
echo "Nolove"
