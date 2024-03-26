// ECS requires the user/role that initiates a deployment
//   to have iam:PassRole access to the execution role
// This grants the deployer user access to this service's execution role
// This is necessary for us to execute `nullstone deploy` on the CLI

resource "aws_iam_user" "deployer" {
  #bridgecrew:skip=CKV_AWS_273: Skipping "Ensure access is controlled through SSO and not AWS IAM defined users". SSO is unavailable to configure.
  name = "deployer-${local.resource_name}"
  tags = local.tags
}

resource "aws_iam_access_key" "deployer" {
  user = aws_iam_user.deployer.name
}

resource "aws_iam_user_policy" "deployer" {
  #bridgecrew:skip=CKV_AWS_40: Skipping `IAM policies attached only to groups or roles reduces management complexity`; Adding a role or group would increase complexity
  user   = aws_iam_user.deployer.name
  policy = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    sid     = "AllowPassRoleToServiceRoles"
    effect  = "Allow"
    actions = ["iam:PassRole"]

    resources = [
      aws_iam_role.execution.arn,
      aws_iam_role.task.arn,
    ]
  }

  statement {
    sid    = "AllowEditJobDefinitions"
    effect = "Allow"
    actions = [
      "batch:DeregisterJobDefinition",
      "batch:DescribeJobDefinitions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowRegisterJobDefinitions"
    effect = "Allow"
    actions = [
      "batch:RegisterJobDefinition",
    ]

    resources = [aws_batch_job_definition.this.arn_prefix]
  }
}
