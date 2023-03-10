# Event Bridge rule for whenever ECS, RDS, Backups, and DynamoDB don't meet the required tags
resource "aws_cloudwatch_event_rule" "required_tags" {
  count = var.control_tower_enabled == false ? 1 : 0

  name = "${var.name_prefix}-backup-notifications${local.name_suffix}"

  event_bus_name = "default"
  event_pattern = jsonencode(
    {
      detail = {
        configRuleName = [
          "required-tags"
        ]
        resourceType = [
          "AWS::EC2::Instance",
          "AWS::RDS::DBInstance",
          "AWS::EC2::Volume",
          "AWS::EFS::FileSystem",
          "AWS::Backup::BackupSelection",
          "AWS::DynamoDB::Table",
        ]
      }
      detail-type = [
        "Config Rules Compliance Change"
      ]
      source = [
        "aws.config"
      ]
    }
  )
  is_enabled = true

  tags = merge({ "Name" = "${var.name_prefix}-backup-notifications${local.name_suffix}" }) # Common tags applied at provider level - additional tags may be added here
}

resource "aws_cloudwatch_event_target" "aws_backup_to_sns" {
  count = var.control_tower_enabled == false ? 1 : 0

  arn            = aws_sns_topic.infrastructure_alerts.arn
  event_bus_name = "default"
  rule           = aws_cloudwatch_event_rule.required_tags[0].name
  target_id      = "${var.name_prefix}-backup-notifications${local.name_suffix}"
}
