resource "intersight_deviceconnector_policy" "dc_policy" {
  for_each        = { for dc in var.dc : dc.Name => dc }
  name            = each.value.Name
  description     = each.value.Description
  lockout_enabled = each.value.LockoutEnabled
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