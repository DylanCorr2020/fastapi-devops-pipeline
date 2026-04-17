variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "ami_id" {
  default = "ami-0324bce2436ce02b2"
}

variable "key_name" {
  default = "fastapi-dev-key"
}
