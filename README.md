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

```
aws configure

```

2.  

Once I collated my research I first created the VPC, I did this my using a VPC module. The VPC module was then edited to fit a simple use case.

Since I knew the RDS uses a username and password, I then tested a password generator, one that would then send it to the secrets manager. This is a method I like to use, because this was we wouldn't have the password stored in a repositor for all to see.

I then created the RDS, I provided with an allocated storage of 100 and ensured the instance class was set as large over micro. this follows as the RDS needs to be highly available. Finally an optional variable that is used multi-az was set to true to ensure that the rds is Multi-AZ. 

3. 

To test everything was correctly formatted and good enough I wrote the following code.

```
terraform init 

terraform validate

terraform fmt
```

'init' initialised the script in regards to the versions I had stated.
'validate' allowed me to validate the current codebase internally for syntax and inconsistencies
'fmt' This allowed me to refactor the code to the correct terraform format.

I then realised I forogt to attach the VPC so I wrote up the subnet group resourse and attached it.

To finish I ran terraform validate and fmt one more time.

4. 
Testing the code worked meant I would need to run it through AWS, I used my free tier account. Once configured I ran the following code to apply what I had used to be built in AWS using the terraform code

```
terraform plan 

terraform apply 

```

'terraform plan' is used to view how the code would be built, it shows us how everything is will be applied and if any errors exist. 

'terraform apply' this also performs a plan but then asks whether to actually apply the planned changes. when you say yes it goes ahead and begins building. The rds it self took 8 mins to build and successfully so.
**Another way to apply is to type 'terraform apply -auto-approve this automatically begins applying the resources without the promt useful if you''ve already typed out 'terraform plan'**

Once the plan was complete I checked AWS to see how everything was made then went on to pull it all down.

```
terraform destroy -auto-approve

```

'destroy' pulls down everything in the current state. 

5. 
Finally I cleaned everything up by creating a vars.tf and terraform.tfvars. Here I placed all the customizable variables.

I tested everything one last time and finished off the README

<sub>I hope you guys understood this, this was a fun task</sub>
