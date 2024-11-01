resource "aws_wafv2_web_acl" "this" {
  name        = "${var.name}-web-acl"
  description = "WAF for ALB"
  scope       = var.scope
  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      name     = rule.value["name"]
      priority = rule.value["priority"]

      action {
        block {}
      }

      statement {
        rate_based_statement {
          limit              = rule.value.limit
          aggregate_key_type = "IP"
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = rule.value["metric_name"]
      }
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = var.metric_name
  }
}

resource "aws_wafv2_web_acl_association" "this" {
  count        = var.associate_web_acl ? 1 : 0
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}