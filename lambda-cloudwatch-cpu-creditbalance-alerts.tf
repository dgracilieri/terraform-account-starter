module "cpu_burst_balance_lambda" {

  source  = "StratusGrid/lambda-event-handler-cpu-creditbalance/aws"
  version = "~> 2.0"

  name_prefix                 = var.name_prefix
  name_suffix                 = local.name_suffix
  unique_name                 = "event-handler-cpu-burst-balance"
  sns_alarm_target            = aws_sns_topic.infrastructure_alerts.arn
  kms_log_key_deletion_window = 30
  input_tags                  = merge() # This is blank for module compatability, we feed it null tags as our provider level will take over
}
