locals {
  yaml_file = file("${path.module}/config.yaml")
  config    = yamldecode(local.yaml_file)
}
