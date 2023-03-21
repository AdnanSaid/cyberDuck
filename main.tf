# Grab vpc module from terraform modules

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "mighty-rds-vpc"

   # Choose an uncommon IP Address range to make IP address collisions more uncommon in the future
  # For VPC peerings, external private connections etc
  # /24 and /27 chosen to have enough space for resources but not too large to overuse IP Address space

  cidr = "10.0.175.0/24"

  azs                  = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets       = ["10.0.101.0/27", "10.0.102.0/27", "10.0.103.0/27"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Enviroment = "dev"
  }
}

