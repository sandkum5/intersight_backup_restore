resource "intersight_kvm_policy" "kvm_policy" {
  for_each                  = { for vkvm in var.vkvm : vkvm.Name => vkvm }
  name                      = each.value.Name
  description               = each.value.Description
  enabled                   = each.value.Enabled
  maximum_sessions          = each.value.MaximumSessions
  enable_video_encryption   = each.value.EnableVideoEncryption
  remote_port               = each.value.RemotePort
  enable_local_server_video = each.value.EnableLocalServerVideo
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