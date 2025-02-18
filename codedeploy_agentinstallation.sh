#!/bin/bash
sudo yum update
sudo yum install ruby
sudo yum install wget

#install docker
sudo dnf update
sudo systemctl start docker

# install codedeploy
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto
systemctl start codedeploy-agent
systemctl status codedeploy-agent
echo "script finished"