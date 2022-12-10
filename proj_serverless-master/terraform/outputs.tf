output "bucket_domain_name" {
	value = aws_s3_bucket.lukasz-maslaczyk-bucket.*.bucket_domain_name
	description = "FQDN of bucket"
}

output "bucket_website_endpoind" {
	value = aws_s3_bucket_website_configuration.lukasz-maslaczyk-bucket.*.website_endpoint
	description = "The bucket website endpoint, if the site is enabled"
}

output "bucket_arn" {
	value = aws_s3_bucket.lukasz-maslaczyk-bucket.*.arn
	description = "Bucket ARN"
}
