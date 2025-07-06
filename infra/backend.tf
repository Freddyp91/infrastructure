terraform {
  backend "s3" {
    bucket = "tech-with-freddy-state"
    key    = "infra"
    region = "us-east-1"
  }
}
