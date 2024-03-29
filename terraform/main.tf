#resource "aws_key_pair" "mykey-id" {
 # key_name   = "userkey"
  #public_key = file(var.PATH_TO_PUBLIC_KEY)
#}

module "ec2_clusters" {
  for_each       = { "nginx" = [module.vpc.public_subnets[0], "eu-west-1a"], "blue" = [module.vpc.public_subnets[0], "eu-west-1a"], "green" = [module.vpc.public_subnets[1], "eu-west-1b"], "redis" = [module.vpc.public_subnets[0], "eu-west-1a"]}
  source         = "terraform-aws-modules/ec2-instance/aws"
  version        = "~> 2.0"
  name           = "${each.key}_Server"
  instance_count = 1
  ami                    = var.AMI_ID
  instance_type          = "t2.micro"
  key_name               = ""
  monitoring             = true
  #az_zone                = each.value[1]
  vpc_security_group_ids = [aws_security_group.sg-dev.id]
  subnet_id              = each.value[0] #module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${each.key}_Server"
  }
}
