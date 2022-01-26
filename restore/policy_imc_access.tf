resource "intersight_access_policy" "imc_access" {
  for_each    = { for entry in var.imc_access : entry.Name => entry }
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
  address_type {
      enable_ip_v4 = each.value.AddressType.EnableIpV4
      enable_ip_v6 = each.value.AddressType.EnableIpV6
      }
  inband_vlan  = each.value.InbandVlan
  inband_ip_pool {
    object_type = "ippool.Pool"
    selector    = "$filter=Name eq '${each.value.InbandIpPool.Name}'"
  }
}