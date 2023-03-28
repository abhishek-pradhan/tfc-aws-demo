output "my-s3-bucket" {
  value = module.s3_bucket
}

output "my-kms" {
  value = module.kms
}

output "ab_cdn_bucket" {
  value = data.aws_s3_bucket.ab_cdn_bucket
}
