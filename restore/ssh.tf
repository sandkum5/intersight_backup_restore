resource "intersight_ssh_policy" "ssh_policy" {
    for_each = {for ssh in var.ssh : ssh.Name => ssh}
    name        = each.value.Name
    description = each.value.Description
    enabled     = each.value.Enabled
    port        = each.value.Port
    timeout     = each.value.Timeout
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
