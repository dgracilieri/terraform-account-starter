Init:
awsudo -u \<profile\> terraform init

Apply all policies first:
awsudo -u \<profile\> terraform apply -var region=us-east-1 -var name_prefix=\<prefix\> -var env_name=\<env\> -target aws_iam_policy.restricted_admin

Apply:
awsudo -u \<profile\> terraform apply -var region=us-east-1 -var name_prefix=\<prefix\> -var env_name=\<env\> 