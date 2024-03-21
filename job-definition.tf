resource "aws_batch_job_definition" "this" {
  name = local.resource_name
  type = "container"

  platform_capabilities = [
    "FARGATE",
  ]

  container_properties = jsonencode({
    command    = local.command
    image      = "${local.service_image}:${local.app_version}"
    jobRoleArn = "arn:aws:iam::123456789012:role/AWSBatchS3ReadOnly"

    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }

    resourceRequirements = [
      {
        type  = "VCPU"
        value = var.cpu
      },
      {
        type  = "MEMORY"
        value = var.memory
      }
    ]

    environment = [for k, v in local.all_env_vars : { name = k, value = v }]
    secrets     = local.all_secret_refs

    logConfiguration = local.log_configuration

    executionRoleArn = aws_iam_role.execution.arn
  })
}

locals {
  command             = length(var.command) > 0 ? var.command : null
  main_container_name = "main"
}