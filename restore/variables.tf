variable "organization" {
  type = list(object({
    Name           = string
    Description    = string
    ResourceGroups = list(map(string))
  }))
  default = []
}

variable "dc" {
  type = list(object({
    Name           = string
    Description    = string
    LockoutEnabled = bool
    Profiles       = list(object({ Name = string }))
    Tags           = list(object({ Key = string, Value = string }))
    Organization   = object({
      Name = string
    })
  }))
  default = []
}

variable "imc_access" {
  type = list(object({
    Name           = string
    Description    = string
    Profiles       = list(object({ Name = string }))
    Tags           = list(object({ Key = string, Value = string }))
    Organization   = object({
      Name = string
    })
    AddressType       = object({
      EnableIpV4 = bool
      EnableIpV6 = bool
    })
    InbandIpPool      = object({ Name = string })
    InbandVlan        = number
    # Missing options in tf resource
    # OutOfBandIpPool = object({ Name = string })
    # ConfigurationType = object({
    #   ConfigureInband    = bool
    #   ConfigureOutOfBand = bool
    # })
  }))
  default = []
}

variable "vic_adapter" {
  type = list(object({
    Name           = string
    Description    = string
    Profiles       = list(object({ Name = string }))
    Tags           = list(object({ Key = string, Value = string }))
    Organization   = object({
      Name = string
    })
    Settings = list(object({
      SlotId = string
      DceInterfaceSettings = list(object({
        FecMode = string
        InterfaceId = number
      }))
      EthSettings = object({
        LldpEnabled = bool
      })
      FcSettings = object({
        FipEnabled = bool
      })
      PortChannelSettings = object({
        Enabled = bool
      })
    }))
  }))
  default = []
}

variable "eth_adapter" {
  type = list(object({
    Name             = string
    Description      = string
    VxlanSettings    = object({Enabled = bool})
    NvgreSettings    = object({Enabled = bool})
    ArfsSettings     = object({Enabled = bool})
    AdvancedFilter   = bool
    InterruptScaling = bool
    GeneveEnabled    = bool
    RoceSettings     = object({
      ClassOfService = number
      Enabled        = bool
      MemoryRegions  = number
      QueuePairs     = number
      ResourceGroups = number
      Version        = number
    })
    InterruptSettings = object({
      CoalescingTime = number
      CoalescingType = string
      Count          = number
      Mode           = string
    })
    RxQueueSettings = object({
      Count=number
      RingSize=number
    })
    TxQueueSettings = object({
      Count = number
      RingSize = number
    })
    CompletionQueueSettings = object({
      Count = number
      RingSize = number
    })
    UplinkFailbackTimeout = number
    TcpOffloadSettings = object({
      LargeReceive = bool
      LargeSend = bool
      RxChecksum = bool
      TxChecksum = bool
    })
    RssSettings = bool
    RssHashSettings = object({
      Ipv4Hash = bool
      Ipv6ExtHash = bool
      Ipv6Hash = bool
      TcpIpv4Hash = bool
      TcpIpv6ExtHash = bool
      TcpIpv6Hash = bool
      UdpIpv4Hash = bool
      UdpIpv6Hash = bool
    })
    Tags        = list(object({ Key = string, Value = string }))
    Organization = map(string)
  }))
  default = []
}


variable "eth_net" {
  type = list(object({
    Name          = string
    Description   = string
    Tags          = list(map(string))
    Organization  = map(string)
    VlanSettings  = object({
      DefaultVlan = number
      Mode = string
    })
  }))
  default = []
}

variable "eth_qos" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    Mtu          = number
    RateLimit    = number
    Cos          = number
    Burst        = number
    Priority     = string
    TrustHostCos = bool
  }))
  default = []
}

variable "eth_net_control" {
  type = list(object({
    Name                = string
    Description         = string
    Tags                = list(map(string))
    Organization        = map(string)
    CdpEnabled          = bool
    MacRegistrationMode = string
    UplinkFailAction    = string
    ForgeMac            = string
    LldpSettings        = object({
      ReceiveEnabled  = bool
      TransmitEnabled = bool
    })
  }))
  default = []
}

variable "eth_net_group" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    VlanSettings = object({
      AllowedVlans = string
      NativeVlan   = number
    })
  }))
  default = []
}

variable "ipmi" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    Enabled      = bool
    Privilege    = string
  }))
  default = []
}

variable "lan_conn" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "ldap" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "local_user" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = map(string)
  }))
  default = []
}

variable "network_conn" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "ntp" {
  type = list(object({
    Name         = string
    Description  = string
    Enabled      = bool
    NtpServers   = list(string)
    Timezone     = string
    Organization = object({
      Name = string
    })
    Profiles = list(object({ Name = string }))
    Tags     = list(object({ Key = string, Value = string }))
  }))
  default = []
}

variable "persistent_memory" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "power" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "san_conn" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "sdcard" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "sol" {
  type = list(object({
    Name         = string
    Description  = string
    Enabled      = bool
    ComPort      = string
    BaudRate     = number
    SshPort      = number
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "smtp" {
  type = list(object({
    Name           = string
    Description    = string
    Enabled        = bool
    MinSeverity    = string
    SenderEmail    = string
    SmtpPort       = number
    SmtpRecipients = list(string)
    SmtpServer     = string
    Profiles       = list(object({ Name = string }))
    Tags           = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "snmp" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "ssh" {
  type = list(object({
    Name         = string
    Description  = string
    Enabled      = bool
    Port         = number
    Timeout      = number
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "storage" {
  type = list(object({
    Name         = string
    Description  = string
    Profiles     = list(object({ Name = string }))
    Tags         = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "syslog" {
  type = list(object({
    Name          = string
    Description   = string
    LocalClients  = list(map(string))
    Organization  = map(string)
    Tags          = list(map(string))
    Profiles      = list(object({ Name = string }))
    RemoteClients = list(map(string))
  }))
  default = []
}

variable "vkvm" {
  type = list(object({
    Name                   = string
    Description            = string
    Enabled                = bool
    EnableLocalServerVideo = bool
    EnableVideoEncryption  = bool
    MaximumSessions        = number
    RemotePort             = number
    Profiles               = list(object({ Name = string }))
    Tags                   = list(object({ Key = string, Value = string }))
    Organization = object({
      Name = string
    })
  }))
  default = []
}

variable "vmedia" {
  type = list(object({
    Name        = string
    Description = string
    Enabled     = bool
    Encryption  = bool
    LowPowerUsb = bool
    Mappings    = list(object({
      DeviceType             = string
      MountProtocol          = string
      VolumeName             = string
      FileLocation           = string
      MountOptions           = string
      Username               = string
      AuthenticationProtocol = string
    }))
    Organization = map(string)
    Tags         = list(map(string))
    Profiles     = list(object({ Name = string }))
  }))
  default = []
}

variable "profiles" {
  type = list(object({
    Name                 = string
    Description          = string
    ServerAssignmentMode = string
    TargetPlatform       = string
    PolicyBucket         = list(map(string))
    Tags                 = list(map(string))
    Organization         = map(string)
  }))
  default = []
}

# Pools
variable "ip_pool" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    IpV4Blocks   = list(object({
      From = string
      Size = number
    }))
    IpV4Config   = object({
      Gateway      = string
      Netmask      = string
      PrimaryDns   = string
      SecondaryDns = string
    })
    IpV6Blocks   = list(object({
      From = string
      Size = number
    }))
    IpV6Config   = object({
      Gateway      = string
      Prefix       = number # Set this to 1(minimum value) when IPv6 not configured.
      PrimaryDns   = string
      SecondaryDns = string
    })
  }))
  default = []
}

variable "iqn_pool" {
  type = list(object({
    Name             = string
    Description      = string
    Tags             = list(map(string))
    Organization     = map(string)
    Prefix           = string
    IqnSuffixBlocks = list(object({
      Suffix = string
      From = number
      Size = number
    }))
  }))
  default = []
}

variable "mac_pool" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    MacBlocks   = list(object({
      From = string
      Size = number
    }))
  }))
  default = []
}

variable "uuid_pool" {
  type = list(object({
    Name             = string
    Description      = string
    Tags             = list(map(string))
    Organization     = map(string)
    Prefix           = string
    Size             = number
    UuidSuffixBlocks = list(object({
      From = string
      Size = number
    }))
  }))
  default = []
}

variable "fc_pool" {
  type = list(object({
    Name         = string
    Description  = string
    Tags         = list(map(string))
    Organization = map(string)
    PoolPurpose  = string
    IdBlocks     = list(object({
      From = string
      Size = number
    }))
  }))
  default = []
}
