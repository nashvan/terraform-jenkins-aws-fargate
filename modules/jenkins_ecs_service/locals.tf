locals {
  aws_region     = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id
  prefix         = "${var.service_name}-${var.app_name}-${var.environment}"
}

