variable "availability_zone" {
  description = "(required) https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#availability_zone"
  default     = ""
}

variable "snapshot_id" {
  description = "(optional) https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#snapshot_id"
  default     = ""
}

variable "encrypted" {
  description = "(optional) https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#encrypted"
  default     = "true"
}

variable "size" {
  description = "(optional) https://www.terraform.io/docs/providers/aws/r/lb_target_group.html#target_type"
  default     = "50"
}

variable "env" {
  description = "(optional) Unique identifier used to name all resources"
  default     = "default"
}

variable "tags" {
  description = "(optional) Additional tags applied to all resources"
  default     = {}
}
