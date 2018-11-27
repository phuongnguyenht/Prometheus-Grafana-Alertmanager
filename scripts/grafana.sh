#!/bin/bash
echo "Start Grafana"
cd /opt/grafana/bin
#./grafana-server --config = /opt/grafana/conf/custom.ini
./grafana-server web
