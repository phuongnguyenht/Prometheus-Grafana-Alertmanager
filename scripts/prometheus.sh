#!/bin/bash
cd /opt/Prometheus
echo "Start Prometheus"
nohup ./prometheus --config.file=prometheus.yml --alertmanager.timeout=10s --web.enable-admin-api &
#nohup ./prometheus --config.file=prometheus.yml --alertmanager.timeout=10s --web.enable-admin-api --web.listen-address="0.0.0.0:80" &

