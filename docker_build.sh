#!/usr/bin/env bash
docker build --build-arg UID=$UID \
             --build-arg http_proxy=http://webproxy.its.manchester.ac.uk:3128 \
             --build-arg https_proxy=http://webproxy.its.manchester.ac.uk:3128 \
             -t diffrl:pytorch . 

docker tag diffrl:pytorch avirupdas55/diffrl:pytorch
docker login -u avirupdas55
docker push diffrl/ppo:pytorch