provider "aws" {
region = "us-east-1"

}

data "aws_ami" "myami"{

owners = ["amazon"]
most_recent = true

filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }


}

resource "aws_vpc" "sl-vpc" {
  cidr_block       = "10.0.0.0/16"
   tags = {
    Name = "sl-vpc-01"
  }
}
