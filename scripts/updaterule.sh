#!/bin/sh
cd /opt/Prometheus 
./promtool update rules rules/alert-rules.yml 
#./promtool check rules  rules/alert-rules.yml
