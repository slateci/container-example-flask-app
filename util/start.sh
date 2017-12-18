#!/bin/bash

CLUSTER=$(minikube status)
STATUS=$?
if [ "$STATUS" -lt 1 ]; then
  echo "Existing minikube detected.";
  minikube delete
else
  echo "Starting fresh!";
fi

minikube start --memory 4096

sleep 10;

pwd=$(pwd)

minikube ssh "cd ${pwd} && ./util/build.sh"

kubectl apply -f infrastructure/flask-deployment.yaml
kubectl apply -f infrastructure/flask-service.yaml
kubectl apply -f infrastructure/nginx-configmap.yaml
kubectl apply -f infrastructure/nginx-deployment.yaml
kubectl apply -f infrastructure/nginx-service.yaml
