module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description = "kms key created by terraform"
  key_usage   = "ENCRYPT_DECRYPT"

  # An alias is a friendly name for a AWS KMS key
  aliases = var.kms_aliases

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_resourcegroups_group" "test" {
  name = "rg-tfc-aws-demo"

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
            "Values": ["dev"]
          },
          {
            "Key": "Terraform",
            "Values": ["true"]
          }    
        ]
      }
      JSON
  }
}

