terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      # version = "1.0.21"
    }
  }
}

provider "intersight" {
  apikey        = "./ApiKey.txt"
  secretkey     = "./SecretKey.txt"
  endpoint      = "https://intersight.com"
}
