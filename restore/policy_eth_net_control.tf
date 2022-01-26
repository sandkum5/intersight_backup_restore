resource "intersight_fabric_eth_network_control_policy" "eth_net_control" {
  for_each    = { for entry in var.eth_net_control : entry.Name => entry }
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
  cdp_enabled           = each.value.CdpEnabled
  mac_registration_mode = each.value.MacRegistrationMode
  uplink_fail_action    = each.value.UplinkFailAction
  forge_mac             = each.value.ForgeMac
  lldp_settings {
    object_type       = "fabric.LldpSettings"
    receive_enabled  = each.value.LldpSettings.ReceiveEnabled
    transmit_enabled = each.value.LldpSettings.TransmitEnabled
  }
}