variable "name" {
  type        = string
  description = "The name of the WAF ACL"
}

variable "scope" {
  type        = string
  description = "The scope of the WAF ( REGIONAL | CLOUDFRONT )"
  default     = "REGIONAL"
}

variable "rules" {
  type = list(object({
    name        = string
    priority    = number
    limit       = number
    metric_name = string
  }))
  description = "List of WAF rules to apply. Each rule should contain name, priority, limit, and metric_name."
  default     = []
}

variable "metric_name" {
  type        = string
  description = "The name of the metric"
}

variable "associate_web_acl" {
  type        = bool
  description = "If true, associates the Web ACL with the specified resource."
  default     = false
}

variable "resource_arn" {
  type        = string
  description = "The ARN of the resource to protect"
  default     = null
}