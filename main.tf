provider "aws" {
  region = "us-east-1"
  access_key = "AKIA4TOQFFC4RHJKN3OF"
  secret_key = "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"
}

resource "aws_instance" "kubernetes" {
  ami           = "ami-0f8a61b66d1accaee"
  instance_type = "t2.medium"

  tags = {
    Name = "k8s-node"
  }
}
