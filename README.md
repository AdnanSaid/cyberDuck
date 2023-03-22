# cyberDuck
Cyber Duck technical task
A Terraform script setting up a RDS service and is MYSQL compatible 

To start I researched RDS, and went through Hashicorps documentation to understand what an RDS is.
https://developer.hashicorp.com/terraform/tutorials/aws/aws-rds

I then researched 'highly available RDS' I found that for MYSQL and effective instance would be to provision a Multi-AZ deployment.

Upon researching I found that once enabled, Multi-AZ automatically creates a replica this is also a positive.

I used the latest terraform docs and found the resourse that best makes use of the what I am trying to create. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

---

1. 

I first created the provider, this was set up to use the latest terraform version.

I then set profile of the aws provider to be the default profile on my local machine. To do so Installed the AWS cli I then ran the code below in the command line which allowed me to configure the AWS secret and secret access within the local machine.

'''
aws configure

'''

2.  

Once I collated my research I first created the VPC, I did this my using a VPC module. The VPC module was then edited to fit a simple use case.

Since I knew the RDS uses a username and password, I then tested a password generator, one that would then send it to the secrets manager. This is a method I like to use, because this was we wouldn't have the password stored in a repositor for all to see.

I then created the RDS, I provided with an allocated storage of 100 and ensured the instance class was set as large over micro. this follows as the RDS needs to be highly available. Finally an optional variable that is used multi-az was set to true to ensure that the rds is Multi-AZ. 

