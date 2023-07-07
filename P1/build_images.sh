#!/bin/bash
docker build -t host_rgilles - < ./host_rgilles_Dockerfile
docker build -t router_rgilles - < ./router_rgilles_Dockerfile