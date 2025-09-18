#!/bin/bash

# Define ECR repo and tag
ECR_URL="607007849765.dkr.ecr.ca-central-1.amazonaws.com/churn-prediction"
TAG="v1"
REMOTE_IMAGE_TAG="${ECR_URL}:${TAG}"

# Authenticate Docker to ECR
aws ecr get-login-password --region "ca-central-1" | docker login --username AWS --password-stdin "${ECR_URL}"

# Build the image with a single tag
docker build -t churn-prediction .

docker tag churn-prediction:latest 607007849765.dkr.ecr.ca-central-1.amazonaws.com/churn-prediction:latest
# Push the image
#docker push "${REMOTE_IMAGE_TAG}"
docker push 607007849765.dkr.ecr.ca-central-1.amazonaws.com/churn-prediction:latest