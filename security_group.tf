resource "aws_security_group" "vpn" {
  name_prefix = "${var.git}-vpn-"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags, var.tags)

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}