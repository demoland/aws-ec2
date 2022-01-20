output "management_keyname" {
  description = "Management Key Name"
  value       = aws_key_pair.management_key.key_name
}

output "public_ip" {
  description = "Public IP"
  value       = module.ec2_instance.public_ip
}

output "instance_id" {
  description = "Instance ID"
  value       = module.ec2_instance.id
}
