#!/bin/bash
set -e

echo "Installing kubectl..."
sudo snap install kubectl --classic

echo "Downloading Minikube..."
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

echo "Installing Minikube..."
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "Checking Minikube version..."
minikube version

echo "Starting Minikube with Docker driver..."
minikube start --driver=docker --memory=3072 --cpus=2
