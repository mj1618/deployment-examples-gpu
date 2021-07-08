locals {
  vpc_workspace_name = "dxgpu-vpc-${terraform.workspace}"
  pg_workspace_name = "dxgpu-pg-${terraform.workspace}"
  pg_identifier = "dxgpu-pg-${terraform.workspace}"
  pg_name = "dxgpu${terraform.workspace}"
  pg_sg_name = "dxgpu-pg-sg-${terraform.workspace}"
  pg_password_name = "dxgpu-pg-pwd-${terraform.workspace}"
  db_cluster_param_group_name = "dxgpu-cluster-params-${terraform.workspace}"
  db_param_group_name = "dxgpu-pg-params-${terraform.workspace}"
}