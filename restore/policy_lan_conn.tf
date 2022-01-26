# resource "intersight_vnic_lan_connectivity_policy" "lan_conn" {
#   depends_on = ["EthernetNetwork", "EthernetQoS", "EthernetAdapter"]
#   for_each    = { for entry in var.lan_conn : entry.Name => entry }
#   name        = each.value.Name
#   description = each.value.Description
#   organization {
#     object_type = "organization.Organization"
#     moid = data.intersight_organization_organization.data_org_default.results[0].moid
#     # selector    = "$filter=Name eq '${each.value.Organization.Name}'"
#   }
#   dynamic "tags" {
#     for_each = each.value.Tags
#     content {
#       key   = tags.value.Key
#       value = tags.value.Value
#     }
#   }