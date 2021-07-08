terraform {
  backend remote {
    organization = "dxgpu-org"
    workspaces {
      prefix = "dxgpu-app-"
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

data terraform_remote_state ecr {
  backend = "remote"
  config = {
    organization = "dxgpu-org"
    workspaces = {
      name = local.ecr_workspace_name
    }
  }
}

module app_ecs {
  source = "../module_ecs"
  ecr_url = "chrstnhntschl/gpu_burn:latest" # data.terraform_remote_state.ecr.outputs.repository_url # switch with an ecr repo as required
  environment = terraform.workspace
  app_name = local.app_name
  domain_name = local.domain_name
  ecs_app_port = local.app_port
  dx_root_domain = var.dx_root_domain
  environment_variables = [
    {
      name = "NVIDIA_DRIVER_CAPABILITIES",
      value = "all"
    }
  ]
  environment_secrets = []
}
