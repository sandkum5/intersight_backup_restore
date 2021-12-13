resource "intersight_sol_policy" "sol_policy" {
    for_each = {for sol in var.sol : sol.Name => sol}
    name        = each.value.Name
    description = each.value.Description
    enabled     = each.value.Enabled
    com_port    = each.value.ComPort
    baud_rate   = each.value.BaudRate
    ssh_port    = each.value.SshPort
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
