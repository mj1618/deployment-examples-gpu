terraform {
  backend remote {
    organization = "dxgpu-org"
    workspaces {
      name = "dxgpu-user"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
  required_version = "~> 1.0"
}

provider aws {
  region = "ap-southeast-2"
  profile = "root"
}
