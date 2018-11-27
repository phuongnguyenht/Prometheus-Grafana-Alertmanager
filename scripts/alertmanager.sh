#!/bin/bash
cd /opt/alertmanager
echo "Start AlertManager"
./alertmanager --config.file=custom.yml
