module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description = "EC2 AutoScaling key usage"
  key_usage   = "ENCRYPT_DECRYPT"

  # Aliases
  aliases = ["demo/s3"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "tfc-aws-demo-abhi"
  acl    = "private"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_resourcegroups_group" "test" {
  name = "rg-tfc-aws-demo"

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

