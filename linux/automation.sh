#!/bin/bash

# Variables
IMAGE_NAME="golang-webserver"
TAG=$(date +%Y%m%d%H%M%S)
NEW_IMAGE="${IMAGE_NAME}:${TAG}"

# Build Docker Image
echo "Building Docker image..."
cd ../dockerize
docker build -t $NEW_IMAGE .

# Tagging the image
echo "Tagging the Docker image as $NEW_IMAGE"

# Copy and modify the YAML file
echo "Creating new YAML file with updated image..."
cp ../kubernetes/app.yaml ../kubernetes/script.yml
sed "s|MY_NEW_IMAGE|${NEW_IMAGE}|g" ../kubernetes/script.yml > ../kubernetes/new-app.yaml

# Compare current state with new YAML file in Minikube
echo "Comparing the current state in Minikube with new-app.yaml..."
kubectl diff -f ../kubernetes/new-app.yaml

# Done
echo "Automation completed!"
