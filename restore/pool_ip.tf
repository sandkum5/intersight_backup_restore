resource "intersight_ippool_pool" "ip_pool" {
  for_each    = { for entry in var.ip_pool : entry.Name => entry }
  name        = each.value.Name
  description = each.value.Description
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.data_org_default.results[0].moid
    # selector    = "$filter=Name eq '${each.value.Organization.Name}'"
  }
  dynamic "tags" {
    for_each = each.value.Tags
    content {
      key   = tags.value.Key
      value = tags.value.Value
    }
  }
  assignment_order = "sequential"
  dynamic "ip_v4_blocks" {
      for_each = each.value.IpV4Blocks
      content {
          from = ip_v4_blocks.value.From
          size = ip_v4_blocks.value.Size
      }
  }
  ip_v4_config {
    gateway       = each.value.IpV4Config.Gateway
    netmask       = each.value.IpV4Config.Netmask
    primary_dns   = each.value.IpV4Config.PrimaryDns
    secondary_dns = each.value.IpV4Config.SecondaryDns
  }
  dynamic "ip_v6_blocks" {
      for_each = each.value.IpV6Blocks
      content {
          from = ip_v6_blocks.value.From
          size = ip_v6_blocks.value.Size
      }
  }
  ip_v6_config {
    gateway       = each.value.IpV6Config.Gateway
    prefix        = each.value.IpV6Config.Prefix
    primary_dns   = each.value.IpV6Config.PrimaryDns
    secondary_dns = each.value.IpV6Config.SecondaryDns
  }
}