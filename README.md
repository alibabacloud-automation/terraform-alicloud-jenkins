Terraform module for a highly available Jenkins deployment on Alibaba Cloud  
terraform-alicloud-jenkins
----------


English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-jenkins/blob/master/README-CN.md)

Terraform module which creates Jenkins deployment on ecs on Alibaba Cloud. 

These types of resources are supported:

* [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## Usage

```hcl
module "jenkins" {
  source = "terraform-alicloud-modules/jenkins/alicloud"

  instance_name               = "myJenkins1"
  instance_password           = "YourPassword123"
  instance_type               = "ecs.n1.small"
  system_disk_category        = "cloud_efficiency"
  security_group_ids          = ["sg-12345678"]
  vswitch_id                  = "vsw-fhuqiexxxxxxxxxxxx"
  internet_max_bandwidth_out  = 50
}
```

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-jenkins/tree/master/examples/complete)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/jenkins"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "jenkins" {
  source               = "terraform-alicloud-modules/jenkins/alicloud"
  version              = "1.0.0"
  region               = "cn-hangzhou"
  profile              = "Your-Profile-Name"
  instance_type        = "ecs.n1.small"
  system_disk_category = "cloud_efficiency"
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "jenkins" {
  source               = "terraform-alicloud-modules/jenkins/alicloud"
  instance_type        = "ecs.n1.small"
  system_disk_category = "cloud_efficiency"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "jenkins" {
  source               = "terraform-alicloud-modules/jenkins/alicloud"
  providers = {
    alicloud = alicloud.hz
  }
  instance_type        = "ecs.n1.small"
  system_disk_category = "cloud_efficiency"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com). 

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
