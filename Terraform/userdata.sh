#!/bin/bash
apt update -y
apt install docker.io -y
systemctl enable docker
systemctl start docker

docker run -d --name prometheus -p 9090:9090 prom/prometheus
docker run -d --name grafana -p 3000:3000 grafana/grafana