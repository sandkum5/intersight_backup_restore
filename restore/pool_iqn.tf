resource "intersight_iqnpool_pool" "iqn_pool" {
  for_each    = { for entry in var.iqn_pool : entry.Name => entry }
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
  dynamic "iqn_suffix_blocks" {
    for_each = each.value.IqnSuffixBlocks
    content {
        suffix = iqn_suffix_blocks.value.Suffix
        from   = iqn_suffix_blocks.value.From
        size   = iqn_suffix_blocks.value.Size
    }
  }
}
