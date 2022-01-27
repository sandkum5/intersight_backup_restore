resource "intersight_vnic_eth_if" "eth_if" {
  depends_on = [intersight_vnic_lan_connectivity_policy.lan_conn]
  for_each    = { for entry in var.eth_ifs : entry.Moid => entry }
  name        = each.value.Name
  dynamic "tags" {
    for_each = each.value.Tags
    content {
      key   = tags.value.Key
      value = tags.value.Value
    }
  }
  cdn {
      object_type = "vnic.Cdn"
      nr_source = each.value.Cdn.Source
      value = each.value.Cdn.Value
  }
  dynamic "eth_adapter_policy" {
    for_each = each.value.EthAdapterPolicy != null ? [1] : []
    content {
      object_type = "vnic.EthAdapterPolicy"
      selector = "$filter=Name eq '${each.value.EthAdapterPolicy.Name}'"
    }
  }
  dynamic "eth_network_policy" {
    for_each = each.value.EthNetworkPolicy != null ? [1] : []
    content {
      object_type = "vnic.EthNetworkPolicy"
      selector = "$filter=Name eq '${each.value.EthNetworkPolicy.Name}'"
    }
  }
  dynamic "eth_qos_policy" {
    for_each = each.value.EthQosPolicy != null ? [1] : []
    content {
      object_type = "vnic.EthQosPolicy"
      selector = "$filter=Name eq '${each.value.EthQosPolicy.Name}'"
    }
  }
  dynamic "fabric_eth_network_control_policy" {
    for_each = each.value.FabricEthNetworkControlPolicy != null ? [1] : []
    content {
      object_type = "fabric.EthNetworkControlPolicy"
      selector = "$filter=Name eq '${each.value.FabricEthNetworkControlPolicy.Name}'"
    }
  }
  dynamic "fabric_eth_network_group_policy" {
    # Reported bug on the returned list value. Should be a map object.
    # for_each = length(each.value.FabricEthNetworkGroupPolicy) != 0 ? [1] : []
    for_each = length(each.value.FabricEthNetworkGroupPolicy) != 0 ? [1] : []
    content {
      object_type = "fabric.EthNetworkGroupPolicy"
      selector = "$filter=Name eq '${try(each.value.FabricEthNetworkGroupPolicy[0].Name, "")}'"
      # When the returned object is a map use below selector.
      # selector = "$filter=Name eq '${try(each.value.FabricEthNetworkGroupPolicy.Name, "")}'"
    }
  }
  failover_enabled = each.value.FailoverEnabled
  dynamic "iscsi_boot_policy" {
    for_each = each.value.IscsiBootPolicy != null ? [1] : []
    content {
      object_type = "vnic.IscsiBootPolicy"
      selector = "$filter=Name eq '${each.value.IscsiBootPolicy.Name}'"
    }
  }
  iscsi_ip_v4_address_allocation_type = each.value.IscsiIpV4AddressAllocationType
  iscsi_ip_v4_config {
      gateway       = each.value.IscsiIpV4Config.Gateway
      netmask       = each.value.IscsiIpV4Config.Netmask
      primary_dns   = each.value.IscsiIpV4Config.PrimaryDns
      secondary_dns = each.value.IscsiIpV4Config.SecondaryDns
  }
  iscsi_ipv4_address = each.value.IscsiIpv4Address
  dynamic "lan_connectivity_policy" {
    for_each = each.value.LanConnectivityPolicy != null ? [1] : []
    content {
      object_type = "vnic.LanConnectivityPolicy"
      selector = "$filter=Name eq '${each.value.LanConnectivityPolicy.Name}'"
    }
  }
  mac_address      = each.value.MacAddress
  mac_address_type = each.value.MacAddressType
  dynamic "mac_pool" {
    for_each = each.value.MacPool != null ? [1] : []
    content {
      object_type = "macpool.Pool"
      selector = "$filter=Name eq '${each.value.MacPool.Name}'"
    }
  }
  order = each.value.Order
  placement {
      id        = each.value.Placement.Id
      pci_link  = each.value.Placement.PciLink
      switch_id = each.value.Placement.SwitchId
      uplink    = each.value.Placement.Uplink
  }
  standby_vif_id     = each.value.StandbyVifId
  static_mac_address = each.value.StaticMacAddress
  usnic_settings {
      object_type          = "vnic.UsnicSettings"
      cos                  = each.value.UsnicSettings.Cos
      nr_count             = each.value.UsnicSettings.Count
      usnic_adapter_policy = each.value.UsnicSettings.UsnicAdapterPolicy
  }
  vif_id = each.value.VifId
  vmq_settings {
      enabled             = each.value.VmqSettings.Enabled
      multi_queue_support = each.value.VmqSettings.MultiQueueSupport
      num_interrupts      = each.value.VmqSettings.NumInterrupts
      num_sub_vnics       = each.value.VmqSettings.NumSubVnics
      num_vmqs            = each.value.VmqSettings.NumVmqs
      vmmq_adapter_policy = each.value.VmqSettings.VmmqAdapterPolicy
  }
}