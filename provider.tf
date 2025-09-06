terraform {
  required_providers {
    tencentcloud = {
      source  = "TencentCloud/tencentcloud"
      version = "~> 1.81.0"
    }
  }
}

provider "tencentcloud" {
  region = "ap-hongkong"
}
