# Set cird block as variable
variable "my_cidr_blocks" {
    default = "172.16.0.0/16"
}

provider "aws" {
  region     = "us-east-1"
}

# Create EC2 instance
module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "my-cluster"
  instance_count = 2

  ami                           = "ami-cfe4b2b0"
  instance_type                 = "t2.micro"
  key_name                      = "EC2Keypair"
  monitoring                    = true
  vpc_security_group_ids        = ["${module.sg_test.this_security_group_id}"]
  subnet_id                     = "subnet-ce04b8e1"
  associate_public_ip_address   = true
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Create Security group add to EC2
module "sg_test" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "terra-test"
  description = "Security group for testing Terraform with custom ports open within VPC publicly open HTTP/HTTPS port 80/443"
  vpc_id      = "vpc-2e591156"

  ingress_cidr_blocks      = ["${var.my_cidr_blocks}"]
  #ingress_rules            = ["http-80-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "${var.my_cidr_blocks}"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "${var.my_cidr_blocks}"
    }
  ]
}