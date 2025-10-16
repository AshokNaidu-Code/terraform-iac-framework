output "instance_ids" {
  description = "IDs of launched EC2 instances"
  value       = aws_instance.main[*].id
}

output "public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.main[*].public_ip
}
