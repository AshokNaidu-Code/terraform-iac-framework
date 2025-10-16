resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier         = "${var.project_name}-db"
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  username           = var.username
  password           = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-instance"
  })
}
