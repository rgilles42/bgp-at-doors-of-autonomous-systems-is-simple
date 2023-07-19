#!/bin/bash
docker build -t host_rgilles - < ./P1/host_rgilles_Dockerfile
docker build -t router_rgilles - < ./P1/router_rgilles_Dockerfile