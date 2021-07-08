
locals {
  vpc_workspace_name = "dxgpu-vpc-${terraform.workspace}"
  cluster_name = "dxgpu-cluster-${terraform.workspace}"
  task_execution_role_name = "dxgpu-execution-role-${terraform.workspace}"
  lb_sg_name = "dxgpu-lb-sg-${terraform.workspace}"
  ecs_tasks_sg_name = "dxgpu-ecs-task-sg-${terraform.workspace}"
  ecs_instance_sg_name = "dxgpu-ecs-instance-sg-${terraform.workspace}"
  instance_log_group_name = "dxgpu-instance-log-group-${terraform.workspace}"
  instance_policy_name = "dxgpu-instance-policy-${terraform.workspace}"
  instance_role_name = "dxgpu-instance-role-${terraform.workspace}"
  instance_profile_name = "dxgpu-instance-profile-${terraform.workspace}"
  instance_key_pair_name = "dxgpu-instance-key-pair-${terraform.workspace}"
  instance_name_prefix = "dxgpu-instance-${terraform.workspace}"
  instance_type = "p2.xlarge" # "t2.small" # 
  ami_name_filter = "amzn2-ami-ecs-gpu-*" # "amzn-ami-*-amazon-ecs-optimized" # 
  public_key_path = "~/.ssh/id_rsa.pub"
  autoscaling_group_name = "dxgpu-ecs-autoscaling-${terraform.workspace}"
  asg_max_size = 2
  asg_min_size = 1
  asg_desired_size = 1
  instance_root_volume_size = 50
}
