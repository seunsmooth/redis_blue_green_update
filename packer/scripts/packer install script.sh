#!/bin/bash

# Packer log settings
export PACKER_LOG=1
export PACKER_LOG_PATH="packerlog.txt"
echo $PACKER_LOG 
echo $PACKER_LOG_PATH
AMI_IDa=`packer build -machine-readable ../redis_blue_green_update/packer/packer.json | tee build.log` 
AMI_ID=`grep 'artifact,0,id' build.log | cut -d, -f6 | cut -d: -f2`
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > ../redis_blue_green_update/terraform/amivar.tf









sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
sudo service docker start
sudo chkconfig docker on
sudo docker run -d  --name grafana  -p 3000:3000  grafana/grafana
sudo apt-get update -y 

sudo apt install -y openjdk-8-jre-headless
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y 
sudo add-apt-repository universe
sudo apt-get -y install jenkins
sudo systemctl enable jenkins 
sudo service jenkins start
sudo apt-get -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx