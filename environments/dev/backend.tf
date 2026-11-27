terraform {
  backend "s3" {
    bucket       = "REPLACE_ME"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
