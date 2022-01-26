resource "intersight_ipmioverlan_policy" "ipmi" {
  for_each    = { for entry in var.ipmi : entry.Name => entry }
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
  enabled        = each.value.Enabled
  privilege      = each.value.Privilege
  # encryption_key = each.value.EncryptionKey
}