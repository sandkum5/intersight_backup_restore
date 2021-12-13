terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      # version = "1.0.21"
    }
  }
}

provider "intersight" {
  apikey        = "<your_api_key_id>"
  secretkey     = "SecretKey.txt"
  endpoint      = "https://intersight.com"
}
