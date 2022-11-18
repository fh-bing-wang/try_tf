# the file should read in a region value
variable "region" {
    type = string
}

# specify provider
provider "aws" {
    region = var.region
}

# filter to find the ami id
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# create an instance
resource "aws_instance" "terraform_ec2_example" {
    ami = data.aws_ami.latest.id
    instance_type = "t2.micro"
    tags = {
        Name = "Bing Terraform"
    }
}

# output from the file
output "my_iam_user_complete_details" {
    value = data.aws_ami.latest.id
}
