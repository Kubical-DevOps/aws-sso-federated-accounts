#
# AWS Organizations
#

resource "aws_organizations_organization" "main" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "guardduty.amazonaws.com",
    "ram.amazonaws.com",
  ]

  feature_set          = "ALL"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}

#
# Primary organizations OU
#

# This OU will contain all our useful accounts and allows us to implement
# organization-wide policies easily.
resource "aws_organizations_organizational_unit" "main" {
  name      = var.org_name
  parent_id = aws_organizations_organization.main.roots.0.id
}

#
# Suspended organization OU
#

# This OU is for locking down accounts we believe are compromised or which
# should not contain any actual resources (like GovCloud placeholders).
resource "aws_organizations_organizational_unit" "suspended" {
  name      = "suspended"
  parent_id = aws_organizations_organization.main.roots.0.id
}

# The org-scp module lets us add some common SCPs to our organization;
# see the README at https://github.com/trussworks/terraform-aws-ou-scp
module "org_scps_main" {
  source  = "trussworks/ou-scp/aws"
  version = "1.5.0"

  target = aws_organizations_organizational_unit.main

  # don't allow all accounts to be able to leave the org
  deny_leaving_orgs = true
  # don't allow access to the root user
  deny_root_account = true
}

module "org_scps_suspended" {
  source  = "trussworks/ou-scp/aws"
  version = "1.5.0"

  target = aws_organizations_organizational_unit.suspended

  # don't allow any access at all
  deny_all = true
}

#
# AWS Organization Accounts
#

resource "aws_organizations_account" "kubical_aws_sso" {
  name      = format("%s-aws-sso", var.org_name)
  email     = format("%s+id@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  # We allow IAM users to access billing from the id account so that we
  # can give delivery/project managers access to billing data without
  # giving them full access to the org-root account.
  iam_user_access_to_billing = "ALLOW"

  tags = {
    Automation = "Terraform"
  }
}


resource "aws_organizations_account" "kubical_aws_dev" {
  name      = format("%s-aws-dev", var.org_name)
  email     = format("%s+dev@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  iam_user_access_to_billing = "DENY"

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_organizations_account" "kubical_aws_preprod" {
  name      = format("%s-aws-preprod", var.org_name)
  email     = format("%s+preprod@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  iam_user_access_to_billing = "DENY"

  tags = {
    Automation = "Terraform"
  }
}


resource "aws_organizations_account" "kubical_aws_prod" {
  name      = format("%s-aws-prod", var.org_name)
  email     = format("%s+prod@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  iam_user_access_to_billing = "DENY"

  tags = {
    Automation = "Terraform"
  }
}
