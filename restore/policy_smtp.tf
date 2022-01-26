resource "intersight_smtp_policy" "smtp_policy" {
  for_each        = { for smtp in var.smtp : smtp.Name => smtp }
  name            = each.value.Name
  description     = each.value.Description
  enabled         = each.value.Enabled
  smtp_server     = each.value.SmtpServer
  smtp_port       = each.value.SmtpPort
  min_severity    = each.value.MinSeverity
  sender_email    = each.value.SenderEmail
  smtp_recipients = each.value.SmtpRecipients
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
