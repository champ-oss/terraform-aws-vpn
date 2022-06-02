resource "aws_cloudwatch_log_group" "this" {
  name_prefix       = "${var.git}-vpn-"
  retention_in_days = var.retention_in_days
  tags              = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "vpn"
  log_group_name = aws_cloudwatch_log_group.this.name
}