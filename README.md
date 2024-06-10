## Requirements
Terraform cli, an AWS account and some bezos bucks
## Preparation
These steps prepare credentials for Terraform to use to connect to AWS and a new instance.
1. Clone this repository
1. Get your aws credentials
(https://docs.aws.amazon.com/IAM/latest/UserGuide/security-creds.html) and
paste them into `~/.aws/credentials`
1. Choose/create a private key for Terraform to use
1. Edit `terraform.tfvars` and add the path to your keys
1. Run `terraform init`

## Launching
1. Run `terraform apply` to spin up a new instance running a Minecraft server on AWS
2. Run `terraform show | grep public_ip` to find your server's public IP
3. Connect to your server!
Terraform will finish running before the Docker container running the Minecraft server
is healthy, so wait for a minute or two if the Minecraft port (25565) is initially closed.
