resource "aws_apprunner_service" "example" {
  service_name = "example"

  source_configuration {
    authentication_configuration {
      connection_arn = "arn:aws:apprunner:us-west-2:305861526072:connection/test/7b6cf46aedfb4b408259f889acd50170"
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "pip install -r requirements.txt"
          port          = "8080"
          runtime       = "PYTHON_3"
          start_command = "python server.py"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/arunlbn/apprunner-test"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
    }
  }

  tags = {
    Name = "example-apprunner-service"
  }
}


resource "aws_apprunner_vpc_connector" "connector" {
  vpc_connector_name = "name"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.sg1.id]
}
