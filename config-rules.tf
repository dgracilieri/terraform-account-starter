module "aws_config_rules_us_east_1" {
  count = var.control_tower_enabled == false ? 1 : 0

  source                        = "StratusGrid/config-rules/aws"
  version                       = "1.3.1"
  include_global_resource_rules = true #only include global resource on one region to prevent duplicate rules
  required_tags_enabled         = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  # tag1Key   = "Provisioner"
  # tag1Value = "Terraform"
  # tag2Key   = "Customer"
  # tag3Key   = "Application"

  providers = {
    aws = aws.us-east-1
  }

  depends_on = [
    module.aws_config_recorder_us_east_1
  ]
}

module "aws_config_rules_us_east_2" {
  count = var.control_tower_enabled == false ? 1 : 0

  source                = "StratusGrid/config-rules/aws"
  version               = "1.3.1"
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-east-2
  }

  depends_on = [
    module.aws_config_recorder_us_east_2
  ]
}

module "aws_config_rules_us_west_1" {
  count = var.control_tower_enabled == false ? 1 : 0

  source                = "StratusGrid/config-rules/aws"
  version               = "1.3.1"
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-west-1
  }

  depends_on = [
    module.aws_config_recorder_us_west_1
  ]
}

module "aws_config_rules_us_west_2" {
  count = var.control_tower_enabled == false ? 1 : 0

  source                = "StratusGrid/config-rules/aws"
  version               = "1.3.1"
  required_tags_enabled = true
  required_tags = {
    tag1Key = "Environment" # Yes, the actual required format is tag#Key and the required key
  }

  providers = {
    aws = aws.us-west-2
  }

  depends_on = [
    module.aws_config_recorder_us_west_2
  ]
}
