locals {
  launch_template_version = length(var.launch_template_version) == 1 ? var.launch_template_version[0] : aws_launch_template.default.latest_version

}

resource "aws_launch_template" "default" {
  ebs_optimized = var.ebs_optimized

  name_prefix            = var.cluster_name
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags          = merge(
      var.tags,
      {
        "Name" = "Launch Instances"
      }
    )
  }

  vpc_security_group_ids = var.associated_security_group_ids
  user_data              = local.userdata
  tags                   = local.node_group_tags

}