## Requirements
Terraform cli and an AWS account.
## Preparation
1. Clone this repository
1. Get your aws credentials
(https://docs.aws.amazon.com/IAM/latest/UserGuide/security-creds.html) and
paste them into `~/.aws/credentials`.
1. Choose/create a private key for Terraform to use and either
    a. Create a file named `terraform.tfvars` and add the path to your private key: `private_key = "/path/to/your/private_key"`
    b. `terraform apply -var="private_key=/path/to/your/private_key"`
1. Run `terraform init`

## Launching
1. Run `terraform apply`.
2. Run `terraform show | grep public_ip` to find your server's public IP.
