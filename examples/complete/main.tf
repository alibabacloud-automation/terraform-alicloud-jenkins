provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 8
  instance_type_family = "ecs.g9i"
}

data "alicloud_images" "default" {
  most_recent   = true
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "~>1.11"

  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

##################################################################
# Create a new security group using terraform module
##################################################################
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  version = "2.4.1"


  vpc_id = module.vpc.this_vpc_id
  name   = "test-lex-1"
  # ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = ["172.16.0.0/21"]
  ingress_rules       = ["all-all"]
}

module "jenkins" {
  source = "../../"

  instance_name              = "myJenkins1"
  instance_password          = "YourPassword123"
  instance_type              = data.alicloud_instance_types.default.ids[0]
  system_disk_category       = "cloud_essd"
  security_group_ids         = [module.security_group.this_security_group_id]
  vswitch_id                 = module.vpc.this_vswitch_ids[0]
  internet_max_bandwidth_out = 50
  image_id                   = data.alicloud_images.default.images[0].id
}
