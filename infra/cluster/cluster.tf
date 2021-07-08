
resource aws_ecs_cluster main {
  name = local.cluster_name
}

data template_file user_data {
  template = file("${path.cwd}/user_data.sh")

  vars = {
    ecs_cluster                 = aws_ecs_cluster.main.name
    log_group                   = aws_cloudwatch_log_group.instance.name
  }
}

data aws_ami ecs {
  most_recent = true

  filter {
    name   = "name"
    values = [local.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource aws_key_pair user {
  key_name   = local.instance_key_pair_name
  public_key = file(local.public_key_path)
}

resource aws_launch_configuration instance {
  name_prefix          = local.instance_name_prefix
  image_id             = data.aws_ami.ecs.id
  instance_type        = local.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance.name
  user_data            = data.template_file.user_data.rendered
  security_groups      = [aws_security_group.instance.id]
  key_name             = local.instance_key_pair_name

  root_block_device {
    volume_size = local.instance_root_volume_size
    volume_type = "gp2"
  }

}

resource aws_autoscaling_group asg {
  name = local.autoscaling_group_name

  launch_configuration = aws_launch_configuration.instance.name
  vpc_zone_identifier  = data.terraform_remote_state.vpc.outputs.vpc.private_subnets
  max_size             = local.asg_max_size
  min_size             = local.asg_min_size
  desired_capacity     = local.asg_desired_size

  health_check_grace_period = 300
  health_check_type         = "EC2"

}