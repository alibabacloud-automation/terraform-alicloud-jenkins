variable "region" {
  default = "eu-central-1"
}
variable "profile" {
  default = "default"
}
provider "alicloud" {
  region  = var.region
  profile = var.profile
}

data "alicloud_vpcs" "default" {
  is_default = true
}
data "alicloud_vswitches" "default" {
  ids = [data.alicloud_vpcs.default.vpcs.0.vswitch_ids.0]
}
data "alicloud_instance_types" "this" {
  cpu_core_count    = 1
  memory_size       = 2
  availability_zone = data.alicloud_vswitches.default.vswitches.0.zone_id
}

module "jenkins" {
  source  = "../../"
  region  = var.region
  profile = var.profile

  instance_name              = "myJenkins1"
  instance_password          = "YourPassword123"
  instance_type              = data.alicloud_instance_types.this.ids.0
  system_disk_category       = "cloud_efficiency"
  security_group_ids         = [module.security_group.this_security_group_id]
  vswitch_id                 = data.alicloud_vpcs.default.vpcs.0.vswitch_ids.0
  internet_max_bandwidth_out = 50
}

##################################################################
# Create a new security group using terraform module
##################################################################
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  region  = var.region
  profile = var.profile

  vpc_id              = data.alicloud_vpcs.default.ids.0
  name                = "test-lex-1"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
}
