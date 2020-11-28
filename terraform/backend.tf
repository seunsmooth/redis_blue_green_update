terraform {
  backend "s3" {
    bucket = "terraform-state-awoga"
    key    = "terraform/myredis_blue_green"
    region = "eu-west-1"
  }
}