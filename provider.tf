terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  #the profile is set for the credentials stored in the .aws location on the users personal machine. 
  #if there are multiple developers working on this then a common name should be used (however for this task i have used default)
  profile = "default"
}