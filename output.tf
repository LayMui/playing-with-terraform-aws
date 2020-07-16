output "laymui-s3-bucket_versioning" {
    value = aws_s3_bucket.laymui-s3-bucket.versioning[0].enabled
}

output "laymui-s3-bucket_complete_details" {
    value = aws_s3_bucket.laymui-s3-bucket
}

# create a IAM user
resource "aws_iam_user" "my_iam_user" {
    name = "my_iam_user_AAA"
}

output "my_iam_user_complete_details" {
value = aws_iam_user.my_iam_user
}