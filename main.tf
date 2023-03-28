# local variables to avoid hardcoding within this file
locals {
  tags_terraform = "true"
  tags_env       = "dev"
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description = "kms key created by terraform"
  key_usage   = "ENCRYPT_DECRYPT"

  # An alias is a friendly name for a AWS KMS key
  aliases = var.kms_aliases

  tags = {
    Terraform   = local.tags_terraform
    Environment = local.tags_env
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Terraform   = local.tags_terraform
    Environment = local.tags_env
  }
}

resource "aws_resourcegroups_group" "test" {
  name        = "rg-${var.project_prefix}"
  description = "Terraform demo project- ${var.project_prefix}"

  # remember to get below JSON from AWS resource group page! 
  resource_query {
    query = <<JSON
      {
        "ResourceTypeFilters": [
          "AWS::AllSupported"
        ],
        "TagFilters": [
          {
            "Key": "Environment",
            "Values": ["${local.tags_env}"]
          },
          {
            "Key": "Terraform",
            "Values": ["${local.tags_terraform}"]
          }    
        ]
      }
      JSON
  }
}

# please ensure below bucket is already present in your AWS account, for data to work!
# # if it's not present, create a new bucket with some unique name
# Create s3 bucket: $ aws s3api create-bucket --bucket tfc-aws-demo-891223 --create-bucket-configuration LocationConstraint=ap-south-1
# Tag s3 bucket: $ aws s3api put-bucket-tagging --bucket tfc-aws-demo-891223 --tagging "TagSet=[{Key=Terraform, Value=true}, {Key=Environment, Value=dev}]"
# Delete s3 bucket: $ aws s3api delete-bucket --bucket tfc-aws-demo-891223
data "aws_s3_bucket" "demo_data_bucket" {
  bucket = "${var.project_prefix}-891223"
}
