resource "aws_s3_bucket" "react-bucket" {
  bucket        = var.react_bucket_name
  force_destroy = true
  acl           = "public-read"

  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.react_bucket_name}/*",
      "Principal": "*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

output "frontend_url" {
  value = "http://${aws_s3_bucket.react-bucket.website_endpoint}"
}

