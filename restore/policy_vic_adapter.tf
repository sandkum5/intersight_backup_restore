resource "intersight_adapter_config_policy" "adapter_config1" {
  for_each    = { for entry in var.vic_adapter : entry.Name => entry }
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
  dynamic "settings" {
      for_each = each.value.Settings
      content {
          slot_id = settings.value.SlotId
          dynamic "dce_interface_settings" {
              for_each = settings.value.DceInterfaceSettings
              content {
                  fec_mode = dce_interface_settings.value.FecMode
                  interface_id = dce_interface_settings.value.InterfaceId
              }
          }
          eth_settings {
              lldp_enabled = settings.value.EthSettings.LldpEnabled
          }
          fc_settings {
              fip_enabled = settings.value.FcSettings.FipEnabled
          }
          port_channel_settings {
              enabled = settings.value.PortChannelSettings.Enabled
          }
      }
  }
}