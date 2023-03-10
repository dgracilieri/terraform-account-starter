data "aws_iam_policy" "read_only_access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "read_only_restrictions" {
  dynamic "statement" {
    for_each = module.cloudtrail[*].s3_bucket_arn
    content {
      effect = "Deny"
      actions = [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetObjectVersionForReplication",
        "lambda:GetFunction",
        "workdocs:Get*",
        "workmail:Get*",
        "athena:GetQueryResults*",
      ]
      not_resources = [
        "${module.s3_bucket_logging_us_east_1.bucket_arn}/*",
        "${module.s3_bucket_logging_us_east_2.bucket_arn}/*",
        "${module.s3_bucket_logging_us_west_1.bucket_arn}/*",
        "${module.s3_bucket_logging_us_west_2.bucket_arn}/*",
        "${module.cloudtrail[*].s3_bucket_arn}/*",
      ]
      sid = "DenyReadOnlyDataRetrieval"
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "secretsmanager:GetSecretValue",
      "ec2:GetPasswordData",
      "redshift:GetClusterCredentials",
      "cognito-identity:GetCredentialsForIdentity",
      "cognito-identity:GetId",
      "cognito-identity:GetOpenIdToken",
    ]
    resources = [
      "*",
    ]
    sid = "DenyReadOnlySecrets"
  }
}

resource "aws_iam_policy" "read_only_restrictions" {
  count = var.aws_sso_enabled == false ? 1 : 0

  name        = "${var.name_prefix}-read-only-restrictions${local.name_suffix}"
  description = "Policy to restrict read only users from accessing data and secrets."
  policy      = data.aws_iam_policy_document.read_only_restrictions.json
}
