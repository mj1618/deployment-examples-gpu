
locals {
  vpc_workspace_name = "dxgpu-vpc-${var.environment}"
  pg_workspace_name = "dxgpu-pg-${var.environment}"
  cluster_workspace_name = "dxgpu-cluster-${var.environment}"
  lb_name = "dxgpu-${var.app_name}-alb-${var.environment}"
  target_group_name = "dxgpu-${var.app_name}-tg-${var.environment}"
  session_ssm_name = "dxgpu-${var.app_name}-ssm-session-${var.environment}"
  logs_name = "/ecs/service/dxgpu-${var.app_name}-${var.environment}"
  task_definition_name = "dxgpu-task-${var.app_name}-${var.environment}"
  ecs_app_name = "dxgpu-ecs-${var.app_name}-${var.environment}"
  ecs_service_name = "dxgpu-ecs-svc-${var.app_name}-${var.environment}"
  discovery_service_name = "dxgpu-discovery-${var.app_name}-${var.environment}"
  zone_name = var.dx_root_domain
}