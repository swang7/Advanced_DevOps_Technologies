# main.tf

IaC to create an ec2 instance using the latest debian ami.

## How to run

```sh
terraform init (only need to run one time)
terraform apply
```

Input required are:  
cidr - the ip where you will be accessing the ec2 instance. example: 99.104.37.103/32  
ssh_key - key to ssh to ec2 instance  
vpc - your aws vpc  

Output: hostid  

## How to access ec2 debian server

```ssh -i <ssh_key> admin@<hostid from output>```
