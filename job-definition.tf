resource "aws_batch_job_definition" "this" {
  name = local.resource_name
  type = "container"

  platform_capabilities = ["FARGATE"]

  container_properties = jsonencode({
    command    = local.command
    image      = "${local.service_image}:${local.app_version}"
    jobRoleArn = aws_iam_role.task.arn

    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }

    resourceRequirements = [
      {
        type  = "VCPU"
        value = tostring(var.cpu)
      },
      {
        type  = "MEMORY"
        value = tostring(var.memory)
      }
    ]

    environment = [for k, v in local.all_env_vars : { name = k, value = v }]
    secrets     = local.all_secret_refs

    logConfiguration = local.log_configuration

    executionRoleArn = aws_iam_role.execution.arn
  })
}

locals {
  command = length(var.command) > 0 ? var.command : null
}

resource "aws_iam_role" "task" {
  name               = "task-${local.resource_name}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
