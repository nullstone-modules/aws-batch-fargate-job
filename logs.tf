module "logs" {
  source  = "nullstone-modules/logs/aws"
  version = "~> 0.3.0"

  name              = local.resource_name
  tags              = local.tags
  retention_in_days = 90
  kms_key_arn       = aws_kms_alias.this.arn
}

locals {
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-region"        = data.aws_region.this.name
      "awslogs-group"         = module.logs.name
      "awslogs-stream-prefix" = local.block_name
    }
  }
  log_provider = "cloudwatch"
}
