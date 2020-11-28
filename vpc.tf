data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-terraform-bluegreen"
  cidr = var.vpc_cidr

  azs                              = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets                  = var.private_subnets #["10.8.1.0/24", "10.8.2.0/24", "10.8.3.0/24"]
  public_subnets                   = var.public_subnets
  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id] #"10.8.101.0/24", "10.8.102.0/24", "10.8.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags               = var.tags
}