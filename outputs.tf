output "my-s3-bucket" {
  value = module.s3_bucket
}

output "my-kms" {
  value = module.kms
}

output "demo-data-bucket" {
  value = data.aws_s3_bucket.demo_data_bucket
}
