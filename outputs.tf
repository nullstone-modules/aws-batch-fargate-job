output "region" {
  value       = data.aws_region.this.name
  description = "string ||| "
}

output "job_definition_name" {
  value       = aws_batch_job_definition.this.name
  description = "string ||| "
}

output "job_definition_arn" {
  value       = aws_batch_job_definition.this.arn
  description = "string ||| "
}

output "image_repo_name" {
  value       = try(aws_ecr_repository.this[0].name, "")
  description = "string ||| "
}

output "image_repo_url" {
  value       = try(aws_ecr_repository.this[0].repository_url, "")
  description = "string ||| "
}

output "image_pusher" {
  value = {
    name       = try(aws_iam_user.image_pusher[0].name, "")
    access_key = try(aws_iam_access_key.image_pusher[0].id, "")
    secret_key = try(aws_iam_access_key.image_pusher[0].secret, "")
  }

  description = "object({ name: string, access_key: string, secret_key: string }) ||| An AWS User with explicit privilege to push images."

  sensitive = true
}

output "log_provider" {
  value       = local.log_provider
  description = "string ||| "
}

output "log_group_name" {
  value       = module.logs.name
  description = "string ||| "
}

output "log_reader" {
  value       = module.logs.reader
  description = "object({ name: string, access_key: string, secret_key: string }) ||| An AWS User with explicit privilege to read logs from Cloudwatch."
  sensitive   = true
}

output "deployer" {
  value = {
    name       = aws_iam_user.deployer.name
    access_key = aws_iam_access_key.deployer.id
    secret_key = aws_iam_access_key.deployer.secret
  }

  description = "object({ name: string, access_key: string, secret_key: string }) ||| An AWS User with explicit privilege to deploy ECS services."

  sensitive = true
}
