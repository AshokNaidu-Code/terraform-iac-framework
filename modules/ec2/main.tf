resource "aws_instance" "main" {
  count               = var.instance_count
  ami                 = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_pair_name
  subnet_id           = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = var.security_group_ids
  user_data           = var.user_data

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-instance-${count.index + 1}"
  })

  lifecycle {
    create_before_destroy = true
  }
}
