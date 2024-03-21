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
