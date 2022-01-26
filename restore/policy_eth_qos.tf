resource "intersight_vnic_eth_qos_policy" "eth_qos" {
  for_each    = { for entry in var.eth_qos : entry.Name => entry }
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
  mtu            = each.value.Mtu
  rate_limit     = each.value.RateLimit
  cos            = each.value.Cos
  burst          = each.value.Burst
  priority       = each.value.Priority
  trust_host_cos = each.value.TrustHostCos
}