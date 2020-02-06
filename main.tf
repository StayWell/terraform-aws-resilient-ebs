resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.size
  snapshot_id       = var.snapshot_id
  encrypted         = var.encrypted
  type              = "gp2"
  tags              = merge({ "Name" = var.env }, var.tags)
}
