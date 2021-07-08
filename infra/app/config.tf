
locals {
  vpc_workspace_name = "dxgpu-vpc-${terraform.workspace}"
  pg_workspace_name = "dxgpu-pg-${terraform.workspace}"
  ecr_workspace_name = "dxgpu-ecr"
  app_name = "app"
  domain_name = {
    dev = "app.dev.${var.dx_root_domain}"
    prod = "app.${var.dx_root_domain}"
  }[terraform.workspace]
  zone_name = var.dx_root_domain
  node_env = {
    dev = "development"
    prod = "production"
  }[terraform.workspace]
  app_port = 80
}