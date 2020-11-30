#!/bin/bash
# Packer log settings
export PACKER_LOG=1
export PACKER_LOG_PATH="packerlog.txt"
echo $PACKER_LOG 
echo $PACKER_LOG_PATH
AMI_IDa=`packer build -machine-readable ../redis_blue_green_update/packer/packer.json | tee build.log` 
AMI_ID=`grep 'artifact,0,id' build.log | cut -d, -f6 | cut -d: -f2`
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > ../redis_blue_green_update/terraform/amivar.tf
sleep 20
cd ../redis_blue_green_update/terraform/terraform apply -auto-approve 
cd ../redis_blue_green_update/ansible/ && ansible-playbook -i inventory/prod_aws_ec2.yml provisioning/site.yml