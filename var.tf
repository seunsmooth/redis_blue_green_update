variable "region" {
  default = "eu-west-1"
}
variable "instance_count" {
  default = "3"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.7.0.0/16"
}
#
#ariable "account" {
# type = list
# default = {
#   #Prometheus = module.vpc.private_subnets[0] #"subnet-08dac839bf5fc78a1"
#   Grafana    =  module.vpc.public_subnets[0]  #"subnet-05625e43abcf7aa65"
# }
#


variable "private_subnets" {
  default = ["10.7.1.0/24", "10.7.2.0/24", "10.7.3.0/24"]
}

variable "public_subnets" {
  default = ["10.7.10.0/24", "10.7.20.0/24", "10.7.30.0/24"]
}

#ariable "subnet_id" {
# default = "subnet-0ffbe71882deab7b5"
#

#ariable "seun_private_subnets" {
# type = string
# default = module.vpc.private_subnets[0]
#
#
#ariable "seun_public_subnets" {
# type = string
# default = module.vpc.public_subnets[0]
#

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "white_listed_entrants" {
  default = ["87.80.20.214/32", "0.0.0.0/0"]
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "olukey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "olukey"
}

