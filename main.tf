provider "vault" {
  address = "http://127.0.0.1:8200"
}

data "vault_generic_secret" "aws" {
  path = "secret/aws"
}

provider "aws" {
  region     = "eu-west-3"
  access_key = data.vault_generic_secret.aws.data["access_key"]
  secret_key = data.vault_generic_secret.aws.data["secret_key"]
}

resource "aws_s3_bucket" "example" {
  bucket = "myarvidabucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
#provider "github" {
 # token = var.github_token
#}

resource "github_repository" "example" {
  name        = "Test1"
  description = "My awesome codebase for test exercice 2"
  visibility = "public"
}