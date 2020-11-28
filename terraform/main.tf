resource "aws_key_pair" "mykey-id" {
  key_name   = "olukey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

module "ec2_clusters" {
  for_each       = { "app_blue" = [module.vpc.private_subnets[0], "eu-west-1a"], "app_green" = [module.vpc.private_subnets[1], "eu-west-1b"], "web_blue" = [module.vpc.public_subnets[0], "eu-west-1a"],  "web_green" = [module.vpc.public_subnets[1], "eu-west-1b"]}
  source         = "terraform-aws-modules/ec2-instance/aws"
  version        = "~> 2.0"
  name           = "${each.key}_Server"
  instance_count = 1

  ami                    = var.AMI_ID
  instance_type          = "t2.micro"
  key_name               = "olukey"
  monitoring             = true
  az_zone                = each.value[1]
  vpc_security_group_ids = [aws_security_group.sg-dev.id]
  subnet_id              = each.value[0] #module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${each.key}_Server"
  }
}

module "redis" {
  source  = "umotif-public/elasticache-redis/aws"
  version = "~> 1.3.0"

  name_prefix           = "core-example"
  number_cache_clusters = 2
  node_type             = "cache.t2.micro"

  engine_version           = "5.0.6"
  port                     = 6379
  maintenance_window       = "mon:03:00-mon:04:00"
  snapshot_window          = "04:00-06:00"
  snapshot_retention_limit = 7

  automatic_failover_enabled = true

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = "1234567890asdfghjkl"

  apply_immediately = true
  family            = "redis5.0"
  description       = "Test elasticache redis."

  #subnet_ids             = module.vpc.private_subnets[0]

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  parameter = [
    {
      name  = "repl-backlog-size"
      value = "16384"
    }
  ]

  tags = {
    Project = "Test"
  }
}