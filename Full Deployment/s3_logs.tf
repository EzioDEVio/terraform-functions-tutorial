
resource "aws_s3_bucket" "flow_logs" {
  bucket = "ci-cd-demo-flow-logs-${var.environment}"
  acl    = "private"

  tags = {
    Name        = "FlowLogs-${var.environment}"
    Environment = var.environment
  }
}

# Define the Flow Log Resource
resource "aws_flow_log" "vpc_flow_log" {
  log_destination_type = "s3"
  log_destination      = aws_s3_bucket.flow_logs.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.ci_cd_demo_vpc.id

  tags = {
    Name        = "VPCFlowLog-${var.environment}"
    Environment = var.environment
  }
}


#Set Permissions for Writing Logs to S3

resource "aws_s3_bucket_policy" "flow_log_policy" {
  bucket = aws_s3_bucket.flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:PutObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.flow_logs.arn}/*"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      },
      {
        Action    = "s3:GetBucketAcl"
        Effect    = "Allow"
        Resource  = aws_s3_bucket.flow_logs.arn
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      }
    ]
  })
}

