###############
# ECS Instance
################
output "this_public_ip" {
  description = "The instance public ip."
  value       = concat(module.jenkins.this_public_ip, [""])[0]
}

output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = module.jenkins.this_security_group_ids
}

output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = concat(module.jenkins.this_vswitch_id, [""])[0]
}

output "this_instance_id" {
  description = "The instance id."
  value       = concat(module.jenkins.this_instance_id, [""])[0]
}

output "this_instance_name" {
  description = "The instance name."
  value       = concat(module.jenkins.this_instance_name, [""])[0]
}

output "this_private_ip" {
  description = "The instance private ip."
  value       = concat(module.jenkins.this_private_ip, [""])[0]
}

output "this_instance_tags" {
  description = "The tags for this instance."
  value       = module.jenkins.this_instance_tags
}

output "this_image_id" {
  description = "The image ID used by this instance."
  value       = concat(module.jenkins.this_image_id, [""])[0]
}

output "this_instance_type" {
  description = "The instance type."
  value       = concat(module.jenkins.this_instance_type, [""])[0]
}

output "this_availability_zone" {
  description = "The zone id of the instance."
  value       = concat(module.jenkins.this_availability_zone, [""])[0]
}

output "this_jenkins_url" {
  description = "The jenkins Access link."
  value       = format("http://%s:8080/jenkins", concat(module.jenkins.this_public_ip, [""])[0])
}