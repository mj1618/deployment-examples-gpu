
resource aws_cloudwatch_log_group instance {
  name = local.instance_log_group_name
}

data aws_iam_policy_document instance_policy {
  statement {
    sid = "CloudwatchPutMetricData"

    actions = [
      "cloudwatch:PutMetricData",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "InstanceLogging"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "${aws_cloudwatch_log_group.instance.arn}",
    ]
  }
}

resource aws_iam_policy instance_policy {
  name   = local.instance_policy_name
  path   = "/"
  policy = "${data.aws_iam_policy_document.instance_policy.json}"
}

resource aws_iam_role instance {
  name = local.instance_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}

resource aws_iam_role_policy_attachment ecs_policy {
  role       = aws_iam_role.instance.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource aws_iam_role_policy_attachment instance_policy {
  role       = aws_iam_role.instance.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

resource aws_iam_instance_profile instance {
  name = local.instance_profile_name
  role = aws_iam_role.instance.name
}