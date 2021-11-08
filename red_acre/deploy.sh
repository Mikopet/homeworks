#!/usr/bin/env bash

# Building with compose probably not very common (for a reason), but in this case it is better
docker-compose build backend

ACCOUNT_ID=$(aws sts get-caller-identity --output text | grep -Eo '^\S+')
REGION=$(aws configure get region)

REGISTRY_URL="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"
IMAGE_URL="$REGISTRY_URL/red-acre-flask-app:latest"

aws ecr get-login-password | docker login --username AWS --password-stdin $REGISTRY_URL

docker tag red_acre_backend:latest $IMAGE_URL
docker push $IMAGE_URL


# Well, this is not a best practice here. But we want to override the default nginx image
# For this challenge it will do
terraform apply --var="app_image=$IMAGE_URL" terraform/

