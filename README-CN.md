terraform-alicloud-jenkins
=====================================================================

本 Terraform 模块将用于在阿里云上一键部署 Jenkins。

本 Module 支持创建以下资源:

* [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## Terraform 版本

本模板要求使用版本 Terraform 0.12 和 阿里云 Provider 1.56.0+。

## 用法

```hcl
module "jenkins" {
  source = "terraform-alicloud-modules/jenkins/alicloud"
  region                      = "cn-hangzhou"
  profile                     = "Your-Profile-Name"

  instance_name               = "myJenkins1"
  instance_password           = "YourPassword123"
  instance_type               = "ecs.n1.small"
  system_disk_category        = "cloud_efficiency"
  security_group_ids          = ["sg-12345678"]
  vswitch_id                  = "vsw-fhuqiexxxxxxxxxxxx"
  internet_max_bandwidth_out  = 50
}
```

## 示例

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-jenkins/tree/master/examples/complete)

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置。

提交问题
------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
