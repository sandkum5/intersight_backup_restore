resource "intersight_vnic_eth_network_policy" "eth_net" {
  for_each    = { for entry in var.eth_net : entry.Name => entry }
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
    object_type  = "vnic.VlanSettings"
    default_vlan = each.value.VlanSettings.DefaultVlan
    mode         = each.value.VlanSettings.Mode
  }
}