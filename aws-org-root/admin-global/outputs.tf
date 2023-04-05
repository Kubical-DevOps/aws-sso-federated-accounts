# We need to have outputs for all these accounts because we need to
# know the account numbers when we're setting up things in other
# accounts.
output "aws_organizations_account_kubical_aws_root_org_id" {
  description = "Account number for the kubical-aws-org-root account"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_organizations_account_kubical_aws_sso_id" {
  description = "Account number for the kubical-aws-sso account"
  value       = aws_organizations_account.kubical_aws_sso.id
}

output "aws_organizations_account_kubical_aws_dev_id" {
  description = "Account number for the kubical-aws-dev account"
  value       = aws_organizations_account.kubical_aws_dev.id
}

output "aws_organizations_account_kubical_aws_preprod_id" {
  description = "Account number for the kubical-aws-preprod account"
  value       = aws_organizations_account.kubical_aws_preprod.id
}

output "aws_organizations_account_kubical_aws_prod_id" {
  description = "Account number for the kubical-aws-prod account"
  value       = aws_organizations_account.kubical_aws_prod.id
}
