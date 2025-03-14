#!/bin/bash
set -e

# Switch to root user (if not already root)
if [ "$(whoami)" != "root" ]; then
  sudo su - root
fi

# Set required permissions for all files in the current working directory and subdirectories
chmod -R 755 /opt/codedeploy-agent/deployment-root/*/deployment-archive
chown -R root:root /opt/codedeploy-agent/deployment-root/*/deployment-archive

# Define AWS Region and ECR Repository details
REGION="ap-southeast-1"  # Change this as needed
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
ECR_REPO_NAME="my-ecr"  # Change this to your ECR repository name
IMAGE_TAG="latest"  # Change this tag if needed

# Construct the ECR image URI
IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG"

# Authenticate Docker with ECR
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

# Pull the Docker image from Amazon ECR
docker pull "$IMAGE_URI"

# Run the Docker image as a container
docker run -d -p 5000:5000 "$IMAGE_URI"
