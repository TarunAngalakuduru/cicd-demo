#!/bin/bash
set -e

sudo su - root

# Pull the Docker image from Docker Hub
docker pull techwithalok/codepipeline-demo

# Run the Docker image as a container
docker run -d -p 5000:5000 techwithalok/codepipeline-demo
