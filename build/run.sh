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

minikube ssh "cd ${pwd} && ./build/build.sh"

kubectl apply -f local-test/flask-deployment.yaml
kubectl apply -f local-test/flask-service.yaml
kubectl apply -f local-test/nginx-configmap.yaml
kubectl apply -f local-test/nginx-deployment.yaml
kubectl apply -f local-test/nginx-service.yaml
