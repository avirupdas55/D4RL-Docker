#!/usr/bin/env bash
DOCKER_BUILDKIT=1 docker build -t diffrl:pytorch . 

#docker tag diffrl:pytorch avirupdas55/diffrl:pytorch
#docker login -u avirupdas55
#docker push avirupdas55/diffrl:pytorch 
