resource "intersight_fabric_eth_network_group_policy" "eth_net_group" {
  for_each    = { for entry in var.eth_net_group : entry.Name => entry }
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
  vlan_settings {
      native_vlan   = each.value.VlanSettings.NativeVlan
      allowed_vlans = each.value.VlanSettings.AllowedVlans
  }
}