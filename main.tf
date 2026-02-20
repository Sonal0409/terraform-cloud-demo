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
  ami    = data.aws_ami.myami.id 
  instance_type = "t3.micro"

}

