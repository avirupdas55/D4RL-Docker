#!/usr/bin/env bash
docker build --build-arg UID=$UID \
             -t diffrl:pytorch . 

docker tag diffrl:pytorch avirupdas55/diffrl:pytorch
docker login -u avirupdas55
docker push diffrl/ppo:pytorch
