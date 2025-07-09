resource "aws_s3_bucket" "sagemaker-bucket" {
  bucket = "sagemaker-classification"
  tags = {
    Name        = "sagemaker-classification"
    Environment = "aws"
  }
}
resource "aws_iam_role" "breast-cancer-classificatin-execution-role" {
  name = "breast-cancer-classifiction-exeution-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "S3AccessForTrainingAndDeployment",
        "Effect": "Allow",
        "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.sagemaker-bucket.id}/*",
        "arn:aws:s3:::${aws_s3_bucket.sagemaker-bucket.id}/*"
      ]
    },
    {
      "Sid": "SageMakerBasicActions",
      "Effect": "Allow",
      "Action": [
        "sagemaker:CreateTrainingJob",
        "sagemaker:DescribeTrainingJob",
        "sagemaker:CreateModel",
        "sagemaker:CreateEndpoint",
        "sagemaker:CreateEndpointConfig",
        "sagemaker:InvokeEndpoint",
        "sagemaker:DescribeEndpoint",
        "sagemaker:DeleteModel",
        "sagemaker:DeleteEndpoint",
        "sagemaker:DeleteEndpointConfig"
      ],
      "Resource": "*"
    },
    {
      "Sid": "CloudWatchLogsAccess",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Sid": "ECRAccessForFrameworkImages",
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    },
    {
      "Sid": "PassRoleForSageMaker",
      "Effect": "Allow",
      "principal": {
        "Service": "sagemaker.amazonaws.com"
      }
      "Action": "iam:AssumeRole"
    }]})
}