# resource "intersight_organization_organization" "orgs" {
#   for_each = { for org in var.organization : org.Name => org }
#   name = each.value.Name
#   description = each.value.Description
#   dynamic "resource_groups" {
#       for_each = each.value.ResourceGroups
#       content {
#           object_type = "resource.Group"
#           selector = "$filter=Name eq '${resource_groups.value.Name}'"
#       }
#   }
# }