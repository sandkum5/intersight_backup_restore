resource "intersight_syslog_policy" "syslog_policy" {
  for_each    = { for entry in var.syslog : entry.Name => entry }
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
  local_clients {
    min_severity = each.value.LocalClients[0].MinSeverity
    object_type  = "syslog.LocalFileLoggingClient"
  }
  dynamic "remote_clients" {
    for_each = each.value.RemoteClients
    content {
      enabled      = remote_clients.value.Enabled
      hostname     = remote_clients.value.Hostname
      min_severity = remote_clients.value.MinSeverity
      port         = remote_clients.value.Port
      protocol     = remote_clients.value.Protocol
      object_type  = "syslog.RemoteLoggingClient"
    }
  }
}