module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"
  providers = {
    aws = aws.region2
  }

  name = "app-vpc-region2"
  cidr = "10.0.8.0/21"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.8.0/24", "10.0.9.0/24"]
  database_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
  create_database_subnet_group = false
  create_database_subnet_route_table     = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "prod"
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
