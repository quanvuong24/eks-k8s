provider "aws" {
  region     = "us-east-1"
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "my-cluster"
  instance_count = 2

  ami                    = "ami-cfe4b2b0"
  instance_type          = "t2.micro"
  key_name               = "EC2Keypair"
  monitoring             = true
  vpc_security_group_ids = ["sg-885b5bfd"]
  subnet_id              = "subnet-ce04b8e1"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}