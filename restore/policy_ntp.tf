resource "intersight_ntp_policy" "ntp_policy" {
  for_each    = { for entry in var.ntp : entry.Name => entry }
  name        = each.value.Name
  description = each.value.Description
  enabled     = each.value.Enabled
  ntp_servers = each.value.NtpServers
  timezone    = each.value.Timezone
  organization {
    object_type = "organization.Organization"
    selector    = "$filter=Name eq '${each.value.Organization.Name}'"
  }
  dynamic "tags" {
    for_each = each.value.Tags
    content {
      key   = tags.value.Key
      value = tags.value.Value
    }
  }
}
