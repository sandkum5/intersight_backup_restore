# resource "intersight_server_profile" "server_profile" {
#   depends_on = []
#   for_each               = { for profile in var.profiles : profile.Name => profile }
#   name                   = each.value.Name
#   description            = each.value.Description
#   server_assignment_mode = each.value.ServerAssignmentMode
#   target_platform        = each.value.TargetPlatform
#   organization {
#     object_type = "organization.Organization"
#     selector = "$filter=Name eq '${each.value.Organization.Name}'"
#   }
#   dynamic "tags" {
#     for_each = each.value.Tags
#     content {
#       key   = tags.value.Key
#       value = tags.value.Value
#     }
#   }
#   dynamic "policy_bucket" {
#       for_each = each.value.PolicyBucket
#       content {
#           object_type = policy_bucket.value.ObjectType
#           selector = "$filter=Name eq '${policy_bucket.value.Name}'"
#       }
#   }
# assigned_server {
#   object_type = "compute.RackUnit"
#   selector    = "$filter=Name eq '${each.value.Server.Name}'"
# }
# }