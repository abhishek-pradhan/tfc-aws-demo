variable "aws-region" {
  type        = string
  description = "Default region to create AWS resources"
}

variable "s3-bucket-name" {
  type = string
}

variable "kms-aliases" {
  type        = list(any)
  description = "An alias is a friendly name for a AWS KMS key. For example, an alias lets you refer to a KMS key as test-key instead of 1234abcd-12ab-34cd-56ef-1234567890ab."
}