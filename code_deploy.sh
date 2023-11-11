#!/bin/bash
# Packer log settings
export PACKER_LOG=1
export PACKER_LOG_PATH="packerlog.txt"
echo $PACKER_LOG 
echo $PACKER_LOG_PATH
AMI_IDa=`packer build -machine-readable ../redis_blue_green_update/packer/packer.json | tee build.log` 
AMI_ID=`grep 'artifact,0,id' build.log | cut -d, -f6 | cut -d: -f2`
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > ../redis_blue_green_update/terraform/amivar.tf

cd terraform/ && terraform init && terraform apply -auto-approve 
sleep 15
cd ansible/ && ansible-playbook -i inventory/prod_aws_ec2.yml provisioning/site.yml

