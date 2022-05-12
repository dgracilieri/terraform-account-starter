# Basic Terraform Information
region      = "us-east-1"
name_prefix = "sgdev"
env_name    = "dev"
source_repo = "https://github.com/StratusGrid/template-terraform-aws-shared"

# Logic Variables
payer_account                  = false
control_tower_enabled          = true
aws_sso_enabled                = true
cost_anomaly_billing_threshold = 50

# Logging Variables - These won't work in the SG Dev Account
enable_centralized_logging = true
log_archive_account        = false
aws_org_id                 = "o-xxxxxx1xxx"
s3_destination_bucket_name = "sgdev-central-logging-logging"
logging_account_id         = "213255954913"

# Notification Variables
service_limit_email             = "mememasterofdisaster@stratusgrid.com"
cost_anomaly_subscription_email = "mememasterofdisaster@stratusgrid.com"