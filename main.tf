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

#create a random password generator so the password isn't stored in the repository 
#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

resource "random_password" "RDS_mighty_password" { 
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "RDS_stored_pass" { 
  name = "RDS_stored_pass"
}

#once the password is generated it will be stored in the secret manager. This is useful as the random password can be safetly 
#locked away, in the aws account. 

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.RDS_stored_pass.id
  secret_string = <<EOF
   {
    "username": "admin",
    "password": "${random_password.RDS_mighty_password.result}"
   }
EOF
}

#to create a highly availble rds. we would need a large amount of allocated storage, the instance class is set as large
#the most important addition is setting the multi_az as true. this is a highly available deployment of Amazon RDS
#it is available for different engine but most importantly for MySQLs
resource "aws_db_instance" "rds_high_availability" {
  allocated_storage    = 100
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.large"
  username             = "admin"
  password             = random_password.RDS_password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = true
}