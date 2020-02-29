resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.size
  snapshot_id       = var.snapshot_id
  encrypted         = var.encrypted
  type              = "gp2"
  tags              = merge({ "Name" = var.env }, var.tags)

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_backup_vault" "this" {
  name = var.env
  tags = merge({ "Name" = var.env }, var.tags)
}

resource "aws_backup_plan" "this" {
  name = var.env
  tags = merge({ "Name" = var.env }, var.tags)

  rule {
    rule_name           = var.env
    target_vault_name   = aws_backup_vault.this.name
    schedule            = var.schedule
    recovery_point_tags = merge({ "Name" = var.env }, var.tags)

    lifecycle {
      cold_storage_after = var.cold_storage_after
      delete_after       = var.delete_after
    }
  }
}

resource "aws_backup_selection" "this" {
  name         = var.env
  iam_role_arn = aws_iam_role.this.arn
  plan_id      = aws_backup_plan.this.id

  resources = [
    aws_ebs_volume.this.arn,
  ]
}

resource "aws_iam_role" "this" {
  name_prefix = "${var.env}-backup"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.this.name
}
