module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "jenkins_Server"
  instance_count = 1

  ami                    = var.AMI_ID
  instance_type          = "t2.micro"
  key_name               = "olukey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.sg-dev.id]
  subnet_id              = module.vpc.public_subnets[0]


}
