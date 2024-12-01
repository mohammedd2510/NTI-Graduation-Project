resource "aws_s3_bucket" "logs_prod" {
  bucket = "elb-logs-2510"
  force_destroy = true
  tags = {
    Environment = "prod"
  }
}

resource "aws_s3_bucket_policy" "logs_prod_policy" {
  bucket = aws_s3_bucket.logs_prod.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::127311923021:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::elb-logs-2510/AWSLogs/242201296912/*"
    }
  ]
}
EOF
}
