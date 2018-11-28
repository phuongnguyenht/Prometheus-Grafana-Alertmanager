#!/bin/sh
cd /opt/Prometheus 
./promtool check rules /opt/Prometheus/rules/alert-rules.yml
