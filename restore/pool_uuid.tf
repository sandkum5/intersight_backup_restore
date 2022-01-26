resource "intersight_uuidpool_pool" "uuid_pool" {
  for_each    = { for entry in var.uuid_pool : entry.Name => entry }
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
  prefix = each.value.Prefix
  size   = each.value.Size
  dynamic "uuid_suffix_blocks" {
    for_each = each.value.UuidSuffixBlocks
    content {
        from = uuid_suffix_blocks.value.From
        size = uuid_suffix_blocks.value.Size
    }
  }
}