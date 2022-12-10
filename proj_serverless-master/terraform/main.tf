resource "aws_s3_bucket" "lukasz-maslaczyk-bucket" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_acl" "lukasz-maslaczyk-bucket" {
  bucket = aws_s3_bucket.lukasz-maslaczyk-bucket.id
  acl    = var.aclType
}

resource "aws_s3_object" "lukasz-maslaczyk-bucket" {
	bucket = aws_s3_bucket.lukasz-maslaczyk-bucket
	key = var.objectKey
}

resource "aws_s3_bucket_policy" "bucket_policy" {
	bucket = aws_s3_bucket.lukasz-maslaczyk-bucket

	policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "PublicReadGetObject",
"Effect": "Allow",
"Principal": "*",
"Action": "s3.GetObject",
"Resource": "arn:aws:s3:::lukasz-maslaczyk-bucket/*"
}
]
}
POLICY
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
	statement {
		principals {
			type = var.policyDocPrincipalsType
			identifiers = var.policyDocPrincipalsIdentifiers
			}
		actions = var.policyDocPrincipalsActions

		resources = [
		aws_s3_bucket.lukasz-maslaczyk-bucket.arn,
		"${aws_s3_bucket.lukasz-maslaczyk-bucket.arn}/*",
		]
	}
}

resource "aws_s3_bucket_website_configuration" "lukasz-maslaczyk-bucket" {
	bucket = aws_s3_bucket.lukasz-maslaczyk-bucket.bucket

	index_document{
	suffix = var.indexWebFile
	}

	error_document{
		key = var.errorWebFile
	}

	routing_rules = <<EOF
	[{
		"Condition": {
			"KeyPrefixEquals": "docs/"
	},
	"Redirect": {
		"ReplaceKeyPrefixWith": ""
	}
}]
EOF

}
