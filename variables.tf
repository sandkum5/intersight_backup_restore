variable "dc" {
    type = list(object({
        Name           = string
        Description    = string
        LockoutEnabled = bool
        Profiles       = list(object({ Name = string }))
        Tags           = list(object({ Key = string, Value = string}))
        Organization   = object({
            Name = string
        })
    }))
    default = [{
            Name           = "demo_dc1"
            Description    = "DEMO DC1 for SJ location"
            LockoutEnabled = true
            Organization   = { Name = "default" }
            Profiles       = null
            Tags           = []
        }]
    description = <<EOT
    Name              : Name of DC policy
    Description       : Description of the DC Policy
    LockoutEnabled    : If DC lockout is enabled
    Organization.Name : Organization Name
    Tags              : Tags
    Profiles          : Profiles
    EOT
}

variable "ntp" {
    type = list(object({
        Name = string
        Description = string
        Enabled = bool
        NtpServers = list(string)
        Timezone = string
        Organization = object({
            Name = string
        })
        Profiles = list(object({ Name = string }))
        Tags = list(object({ Key = string, Value = string}))
    }))
    default = [{
            Name = "demo-ntp1"
            Description = "DEMO NTP1 for SJ location"
            Enabled = true
            NtpServers = ["1.1.1.1", "2.2.2.2"]
            Timezone = "America/Los_Angeles"
            Organization = { Name = "default" }
            Profiles = null
            Tags = null
        }]
    description = <<EOT
    Name              : Name of NTP policy
    Description       : Description of the NTP Policy
    Enabled           : If NTP Policy is enabled
    NtpServers        : List of NTP servers
    Timezone          : Timezone of the NTP policy
    Organization.Name : Organization Name
    Tags              : Tags
    Profiles          : Profiles
    EOT
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
        Tags           = list(object({ Key = string, Value = string}))
        Organization   = object({
            Name = string
        })
    }))
    default = [{
            Name           = "demo_smtp1"
            Description    = "DEMO SMTP1 for SJ location"
            Enabled        = true
            MinSeverity    = "critical"
            SenderEmail    = ""
            SmtpPort       = 25
            SmtpRecipients = null
            SmtpServer     = "1.1.1.1",
            Organization   = { Name = "default" }
            Profiles       = null
            Tags           = null
        }]
    description = <<EOT
    Name              : Name of SMTP policy
    Description       : Description of the SMTP Policy
    Enabled           : If SMTP Policy is enabled
    MinSeverity       : Min severity
    SenderEmail       : Sender Email
    SmtpPort          : SMTP Port
    SmtpRecipients    : SMTP Recipients
    SmtpServer        : SMTP Server IP
    Organization.Name : Organization Name
    Tags              : Tags
    Profiles          : Profiles
    EOT
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
        Tags         = list(object({ Key = string, Value = string}))
        Organization = object({
            Name = string
        })
    }))
    default = [{
            Name         = "demo_sol1"
            Description  = "DEMO SOL1 for SJ location"
            Enabled      = true
            ComPort      = "com0"
            BaudRate     = 9600,
            SshPort      = 2400,
            Organization = { Name = "default" }
            Profiles     = null
            Tags         = null
        }]
    description = <<EOT
    Name              : Name of SOL policy
    Description       : Description of the SOL Policy
    Enabled           : If SOL Policy is enabled
    ComPort           : Com Port name
    BaudRate          : Baud Rate
    SshPort           : SSH Port Number
    Organization.Name : Organization Name
    Tags              : Tags
    Profiles          : Profiles
    EOT
}

variable "ssh" {
    type = list(object({
        Name         = string
        Description  = string
        Enabled      = bool
        Port         = number
        Timeout      = number
        Profiles     = list(object({ Name = string }))
        Tags         = list(object({ Key = string, Value = string}))
        Organization = object({
            Name = string
        })
    }))
    default = [{
            Name         = "demo_ssh1"
            Description  = "DEMO SSH1 for SJ location"
            Enabled      = true
            Port         = 22
            Timeout      = 1800
            Organization = { Name = "default" }
            Profiles     = null
            Tags         = null
        }]
    description = <<EOT
    Name              : Name of SSH policy
    Description       : Description of the SSH Policy
    Enabled           : If SSH Policy is enabled
    Port              : SSH Port Number
    Timeout           : SSH Timeout value
    Organization.Name : Organization Name
    Tags              : Tags
    Profiles          : Profiles
    EOT
}

variable "kvm" {
    type = list(object({
        Name                   = string
        Description            = string
        Enabled                = bool
        EnableLocalServerVideo = bool
        EnableVideoEncryption  = bool
        MaximumSessions        = number
        RemotePort             = number
        Profiles               = list(object({ Name = string }))
        Tags                   = list(object({ Key = string, Value = string}))
        Organization           = object({
            Name = string
            })
    }))
    default = [{
            Name                   = "demo_vkvm1"
            Description            = "DEMO vKVM1 for SJ location"
            Enabled                = true
            EnableLocalServerVideo = true
            EnableVideoEncryption  = true
            Enabled                = true
            MaximumSessions        = 4
            RemotePort             = 2068
            Organization           = { Name = "default" }
            Profiles               = null
            Tags                   = null
        }]
    description = <<EOT
        Name                   : Name of vKVM policy
        Description            : Description of the vKVM Policy
        Enabled                : If vKVM Policy is enabled
        EnableLocalServerVideo : true,
        EnableVideoEncryption  : true,
        Enabled                : true,
        MaximumSessions        : 4,
        RemotePort             : 2068,
        Organization.Name      : Organization Name
        Tags                   : Tags
        Profiles               : Profiles
        EOT
}
