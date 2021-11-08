#!/usr/bin/env bash

#############
## BACKEND ##
#############


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
terraform -chdir=terraform/ apply --var="app_image=$IMAGE_URL"

BACKEND_URL=$(terraform -chdir=terraform/ output backend_url | tr -d '"')
FRONTEND_URL=$(terraform -chdir=terraform/ output frontend_url | tr -d '"')

##############
## FRONTEND ##
##############

echo "REACT_APP_API_URL=$BACKEND_URL" > sys-stats/.env

docker-compose build frontend
docker-compose run frontend npm run build

aws s3 sync sys-stats/build/ s3://red-acre-react-bucket

rm -rf sys-stats/build/


echo "==============================================="
echo "BACKEND_URL: $BACKEND_URL"
echo "FRONTEND_URL: $FRONTEND_URL"

