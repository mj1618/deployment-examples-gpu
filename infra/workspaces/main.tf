terraform {
  required_providers {
    tfe = {
      version = "~> 0.25.0"
    }
  }
}

resource tfe_organization dxgpu-org {
  name  = "dxgpu-org"
  email = "admin@company.com"
}

variable workspace_prefixes {
  type        = list(string)
  default     = ["dxgpu-vpc-", "dxgpu-pg-", "dxgpu-cluster-", "dxgpu-app-"]
}

resource tfe_workspace dev {
  for_each = toset(var.workspace_prefixes)
  name         = "${each.value}dev"
  organization = tfe_organization.dxgpu-org.id
  execution_mode = "local"
}

resource tfe_workspace prod {
  for_each = toset(var.workspace_prefixes)
  name         = "${each.value}prod"
  organization = tfe_organization.dxgpu-org.id
  execution_mode = "local"
}

resource tfe_workspace ecr {
  name         = "dxgpu-ecr"
  organization = tfe_organization.dxgpu-org.id
  execution_mode = "local"
}

resource tfe_workspace user {
  name         = "dxgpu-user"
  organization = tfe_organization.dxgpu-org.id
  execution_mode = "local"
}
