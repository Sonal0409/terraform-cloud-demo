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

resource "aws_instance" "myec2" {
  ami    = "ami-02dfbd4ff395f2a1b" 
  instance_type = "t3.micro"

}



resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}













