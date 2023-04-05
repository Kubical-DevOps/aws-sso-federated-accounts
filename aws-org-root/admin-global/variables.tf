variable "org_email_alias" {
  description = "Email alias for AWS email"
  type        = string
  default     = "infra"
}

variable "org_email_domain" {
  description = "Email domain for AWS email"
  type        = string
  default     = "kubical.io"
}

variable "org_name" {
  description = "AWS Organization name"
  type        = string
  default     = "kubical"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
}
