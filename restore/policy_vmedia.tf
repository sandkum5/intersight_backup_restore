resource "intersight_vmedia_policy" "vmedia_policy" {
  for_each      = { for entry in var.vmedia : entry.Name => entry }
  name          = each.value.Name
  description   = each.value.Description
  enabled       = each.value.Enabled
  encryption    = each.value.Encryption
  low_power_usb = each.value.LowPowerUsb
  dynamic "mappings" {
    for_each = each.value.Mappings
    content {
      device_type    = mappings.value.DeviceType
      mount_protocol = mappings.value.MountProtocol
      # http/https/CIFS/NFS options
      volume_name   = mappings.value.VolumeName
      file_location = mappings.value.FileLocation
      mount_options = mappings.value.MountOptions
      # http/https/CIFS options
      username = mappings.value.Username
      # password = mappings.value.Password # We don't get the password back from intersight
      # cifs options
      authentication_protocol = mappings.value.AuthenticationProtocol
    }
  }
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
}