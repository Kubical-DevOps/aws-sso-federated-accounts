**Once an account is bootstrapped, this directory should not be touched again** unless the account is being torn down. The directory will contain the statefile for these resources, and therefore doing anything with this namespace could break Terraform for the entire account.

No resources should be defined here aside from the two S3 buckets and the DynamoDB table that the bootstrap script creates.
