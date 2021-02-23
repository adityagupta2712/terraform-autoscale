# terraform-project

This terraform project will create two-tier infrastructure in AWS cloud.

Based on your machine install below requirements-

steps to use this repository-

1- install aws-cli -- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

2- install terraform -- https://learn.hashicorp.com/tutorials/terraform/install-cli

3- create a aws profile in your aws credentials files to use with terraform -
default path of credentials file <userhome>/.aws/credentials

4- update your profile -  in main.tf file ex-   profile = "terraform-adi" //update your user-profile for aws keys
i have used singapore region for my infrastructure you can change according to your requirement.

5- create a key pair in AWS console and use key name in  ec2_module/main.tf file in key_name place.

6- clone this project in your machine.

7- run below commands inside project directory.

a- terraform init (this command will initialize terraform in project folder).

b- terraform plan  (this command will list down all the resources it is going to create in aws).

c- terraform apply (this command will create infrastructure in aws, to verify please login to console and verify).

d- terraform destroy (this command will destroy all the infrastructure created with terraform apply).


7- now login to your ec2 instance with ssh key you created and login to rds database with below command-

mysql -h <endpoint_of_your_rds_db_check_in_aws_console> -P 3306 -u root -p

now run below command to create database and table;

**Creating database and table**

```
create database test;

use test;

CREATE TABLE users (
id int(11) NOT NULL auto_increment,
name varchar(100) NOT NULL,
age int(3) NOT NULL,
email varchar(100) NOT NULL,
PRIMARY KEY (id)
);
```
8- also update rds endpoint in your ec2 instances in /opt/nodejs-mysql-crud/config.js file in host part of db configuration

9- check for dns name in load balancer and hit in the browser.
