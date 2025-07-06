terraform {
  backend "s3" {
    bucket = "tech-with-freddy-state"
    key    = "argo-cd"
    region = "us-east-1"
  }
}
