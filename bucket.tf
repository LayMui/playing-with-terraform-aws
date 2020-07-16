# plan - execute
resource "aws_s3_bucket" "laymui-s3-bucket" {
    bucket = "laymui-s3-bucket123"
    versioning {
        enabled = true
    }
}