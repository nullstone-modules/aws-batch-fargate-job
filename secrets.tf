locals {
  // secret_refs is prepared in the form [{ name = "", valueFrom = "<arn>" }, ...] for injection into ECS services
  all_secret_refs = concat(
    [for key, secret in aws_secretsmanager_secret.app_secret : { name = key, valueFrom = secret.arn }],
    [for key, ref in data.ns_env_values.this.unmanaged_secret_refs : { name = key, valueFrom = ref }],
  )
}

resource "aws_secretsmanager_secret" "app_secret" {
  for_each = data.ns_env_layout.this.managed_secret_keys

  name_prefix = "${local.block_name}/${each.value}/"
  tags        = local.tags
  kms_key_id  = aws_kms_alias.this.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "app_secret" {
  for_each = data.ns_env_layout.this.managed_secret_keys

  secret_id     = aws_secretsmanager_secret.app_secret[each.value].id
  secret_string = data.ns_env_values.this.secrets[each.value]

  lifecycle {
    create_before_destroy = true
  }
}
