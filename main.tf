provider "aws" {
  region  = "us-east-1"
  version = "~>2.70"
}

variable "im_user_name_prefix" {
    type = string
    default = "my_iam_users"
}

variable "users" {
  //  default = [ "jane", "john", "mary", "james" ]
  default = {
    jane: { country: "singapore", department: "Business Development"},
    john: { country: "malaysia", department: "Marketing" },
    mary: { country: "new zealand", department: "Engineering"},
    james: { country: "china", department: "IT"}
  }
}

resource "aws_iam_user" "my_iam_users" {
  #count = length(var.names) # using count the update/delete will be based on index
  #name  = "${var.im_user_name_prefix}_${count.index}"
  #name = var.names[count.index]
#  for_each = toset(var.names) #using for_each, the update/delete will be based on value in the set, index_key is the value
  for_each = var.users
    name = each.key
    tags = {
      country: each.value.country
      department: each.value.department
    }
}