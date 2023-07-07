#!/bin/bash
docker build -t host_rgilles-1 - < ./host_rgilles-1_Dockerfile
docker build -t router_rgilles - < ./router_rgilles_Dockerfile