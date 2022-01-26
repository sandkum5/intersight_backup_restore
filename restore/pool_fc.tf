resource "intersight_fcpool_pool" "fc_pool" {
  for_each    = { for entry in var.fc_pool : entry.Name => entry }
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
  pool_purpose = each.value.PoolPurpose
  dynamic "id_blocks" {
    for_each = each.value.IdBlocks
    content {
        from   = id_blocks.value.From
        size   = id_blocks.value.Size
    }
  }
}
