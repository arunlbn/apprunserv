module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
   version = "3.12.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2b", "us-west-2c"]
 
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

  
  resource "aws_security_group" "sg1" {
  name        = "ssh_access_sg"
  description = "Allow ssh traffic on demand"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = "ssh-sg"
  }
}  
