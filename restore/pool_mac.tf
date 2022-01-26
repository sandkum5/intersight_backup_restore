resource "intersight_macpool_pool" "mac_pool" {
  for_each    = { for entry in var.mac_pool : entry.Name => entry }
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
  dynamic "mac_blocks" {
    for_each = each.value.MacBlocks
    content {
        from = mac_blocks.value.From
        size = mac_blocks.value.Size
    }
  }
}