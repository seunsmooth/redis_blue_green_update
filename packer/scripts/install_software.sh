#!/bin/bash
sudo apt-get install unzip
sudo wget https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_linux_amd64.zip
sudo unzip packer_1.5.6_linux_amd64.zip
sudo mv packer /usr/local/bin/packer
sudo wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip
sudo unzip terraform_0.12.25_linux_amd64.zip
sudo mv terraform /usr/local/bin/
sudo apt-get install -y ansible
sudo apt install -y openjdk-8-jre-headless
sudo apt-get update -y
