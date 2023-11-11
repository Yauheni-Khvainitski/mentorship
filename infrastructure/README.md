# Infrastructure as a code with Terraform

## Modules

### Datalake module

S3 bucket. For mentorship purposes in some days data moved to cheaper storage class and after 
some days deleted. It's a good practice for not important data.

### Postgres server

EC2 instance with Postgres 14 database. Before the deployment, the AMI image was created. So, 
the module uses this AMI with preconfigured Postgres. The module also creates a security group.