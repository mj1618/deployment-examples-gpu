terraform {
  backend remote {
    organization = "dxgpu-org"
    workspaces {
      prefix = "dxgpu-pg-"
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
  profile = "deploymentuser"
}

data terraform_remote_state vpc {
  backend = "remote"
  config = {
    organization = "dxgpu-org"
    workspaces = {
      name = local.vpc_workspace_name
    }
  }
}
