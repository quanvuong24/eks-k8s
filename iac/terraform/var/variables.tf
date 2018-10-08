/*
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
*/
provider "aws" {
  #access_key = "${var.access_key}"
  #secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "region" {}
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}

output "ami" {
  value = "${lookup(var.amis, var.region)}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}