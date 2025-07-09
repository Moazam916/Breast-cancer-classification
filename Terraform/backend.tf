terraform {
  backend "s3" {
    bucket = "moazam-tarraform-backend"
    key    = "backend/terraform.tfstate" #Key to file where terraform will write the state of created resources
    region = "us-east-1"
    # dynamodb_table = "moazam-dynamo-table"
  }
}