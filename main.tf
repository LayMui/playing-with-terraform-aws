provider "aws" {
  region  = "us-east-1"
  version = "~>2.70"
}

variable "im_user_name_prefix" {
    type = string
    default = "my_iam_users"
}

variable "names" {
    default = [ "john", "mary", "james" ]
}

resource "aws_iam_user" "my_iam_users" {
  count = length(var.names)
  #name  = "${var.im_user_name_prefix}_${count.index}"
  name = var.names[count.index]
}