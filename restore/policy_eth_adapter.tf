resource "intersight_vnic_eth_adapter_policy" "eth_adapter" {
  for_each    = { for entry in var.eth_adapter : entry.Name => entry }
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
  vxlan_settings {
    enabled = each.value.VxlanSettings.Enabled
  }
  nvgre_settings {
    enabled = each.value.NvgreSettings.Enabled
  }
  arfs_settings {
    enabled = each.value.ArfsSettings.Enabled
  }
  advanced_filter           = each.value.AdvancedFilter
  interrupt_scaling         = each.value.InterruptScaling
  geneve_enabled            = each.value.GeneveEnabled
  roce_settings             = each.value.RoceSettings
  interrupt_settings        = each.value.InterruptSettings
  rx_queue_settings         = each.value.RxQueueSettings
  tx_queue_settings         = each.value.TxQueueSettings
  completion_queue_settings = each.value.CompletionQueueSettings
  uplink_failback_timeout   = each.value.UplinkFailbackTimeout
  tcp_offload_settings      = each.value.TcpOffloadSettings
  rss_settings              = each.value.RssSettings
  rss_hash_settings {
    ipv4_hash         = each.value.RssHashSettings.Ipv4Hash
    ipv6_ext_hash     = each.value.RssHashSettings.Ipv6ExtHash
    ipv6_hash         = each.value.RssHashSettings.Ipv6Hash
    tcp_ipv4_hash     = each.value.RssHashSettings.TcpIpv4Hash
    tcp_ipv6_ext_hash = each.value.RssHashSettings.TcpIpv6ExtHash
    tcp_ipv6_hash     = each.value.RssHashSettings.TcpIpv6Hash
    udp_ipv4_hash     = each.value.RssHashSettings.UdpIpv4Hash
    udp_ipv6_hash     = each.value.RssHashSettings.UdpIpv6Hash
  }
}
