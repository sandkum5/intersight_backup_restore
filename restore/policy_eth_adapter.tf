resource "intersight_vnic_eth_adapter_policy" "eth_adapter" {
  for_each    = { for entry in var.eth_adapter : entry.Name => entry }
  name        = each.value.Name
  description = each.value.Description
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.data_org_default.results[0].moid
    # We can't use the selector as expand filter doesn't work under vnic/EthAdapterPolicies yet.
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
  interrupt_settings {
    coalescing_time = each.value.InterruptSettings.CoalescingTime
    coalescing_type = each.value.InterruptSettings.CoalescingType
    nr_count        = each.value.InterruptSettings.Count
    mode            = each.value.InterruptSettings.Mode
  }
  geneve_enabled            = each.value.GeneveEnabled
  roce_settings {
    class_of_service = each.value.RoceSettings.ClassOfService
    enabled          = each.value.RoceSettings.Enabled
    memory_regions   = each.value.RoceSettings.MemoryRegions
    queue_pairs      = each.value.RoceSettings.QueuePairs
    resource_groups  = each.value.RoceSettings.ResourceGroups
    nr_version       = each.value.RoceSettings.Version
  }
  interrupt_scaling        = each.value.InterruptScaling
  rx_queue_settings {
    nr_count  = each.value.RxQueueSettings.Count
    ring_size = each.value.RxQueueSettings.RingSize
  }
  tx_queue_settings {
    nr_count  = each.value.TxQueueSettings.Count
    ring_size = each.value.TxQueueSettings.RingSize
  }
  completion_queue_settings  {
    nr_count  = each.value.CompletionQueueSettings.Count
    ring_size = each.value.CompletionQueueSettings.RingSize
  }
  uplink_failback_timeout   = each.value.UplinkFailbackTimeout
  tcp_offload_settings {
    large_receive = each.value.TcpOffloadSettings.LargeReceive
    large_send    = each.value.TcpOffloadSettings.LargeSend
    rx_checksum   = each.value.TcpOffloadSettings.RxChecksum
    tx_checksum   = each.value.TcpOffloadSettings.TxChecksum
  }
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
