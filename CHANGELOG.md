# 0.3.0 (Sep 30, 2026)
* Upgraded `nullstone-io/ns` provider to `~> 0.13.0`.
* Replaced `ns_env_variables` and `ns_secret_keys` with the layered `ns_env_layout`, `ns_env_values`, and `ns_env_platform_data` data sources to aggregate environment variables and secrets.
* Emitted the `env` platform data record, including the source of each variable and the Secrets Manager ARN of each managed secret.
* Upgraded capability scaffolding to emit `capability` on capability env vars and secrets and `cap_prefixes`.

# 0.2.1 (Sep 21, 2026)
* Set `propagate_tags = true` on the job definition so the Fargate tasks Batch launches carry the workspace tags.

# 0.2.0 (Jun 19, 2026)
* Upgraded `nullstone-io/ns` provider to `~> 0.11.0`.
* Used `aws_tags` from `data.ns_workspace` to tag all resources via provider `default_tags`.

# 0.1.1 (Mar 05, 2026)
* Upgrade to latest ns terraform provider to improve env var interpolation

# 0.1.0 (Unreleased)
* Initial release
