#!/usr/bin/env python3
import requests
import json
from intersight_auth import IntersightAuth
from decouple import config

def get_object(url):
    """
    Function to make HTTP GET API calls to Intersight and return response in json.
    """
    auth = IntersightAuth(
        secret_key_filename="./SecretKey.txt",
        api_key_id=config("API_KEY_ID")
    )
    base_url = "https://intersight.com/api/v1/"
    expand_url = "$expand=Organization($select=Name),Profiles($select=Name),ClusterProfiles($select=Name),PolicyBucket($select=Name),ResourceGroups($select=Name),InbandIpPool($select=Name),OutOfBandIpPool($select=Name)"
    select_url = "$select=Name,Tags,Description,Organization,Profiles,Settings,ConfiguredBootMode,EnforceUefiSecureBoot,BootDevices,LockoutEnabled,Partitions,BaudRate,ComPort,Enabled,SshPort,Port,Timeout,GlobalHotSpares,M2VirtualDrive,Raid0Drive,UnusedDisksState,UseJbodForVdCreation,DriveGroup,NetworkPolicy,PriorityFlowControlMode,ReceiveDirection,SendDirection,LacpRate,SuspendIndividual,UdldSettings,QuerierIpAddress,QuerierIpAddressPeer,QuerierState,SnoopingState,AlternateIpv4dnsServer,AlternateIpv6dnsServer,DynamicDnsDomain,EnableDynamicDns,EnableIpv4dnsFromDhcp,EnableIpv6,EnableIpv6dnsFromDhcp,PreferredIpv4dnsServer,PreferredIpv6dnsServer,NtpServers,Timezone,EthernetSwitchingMode,FcSwitchingMode,MacAgingSettings,VlanPortOptimizationEnabled,RemoteClients,LocalClients,Classes,AddressType,ConfigurationType,InbandVlan,InbandIpPool,OutOfBandIpPool,PowerProfiling,PowerRestoreState,RedundancyMode,AllocatedBudget,AccessCommunityString,CommunityAccess,EngineId,SnmpPort,SnmpTraps,SnmpUsers,SysContact,SysLocation,TrapCommunity,V2Enabled,V3Enabled,FanControlMode,AddonConfiguration,AddonDefinition,ClusterProfiles,DockerBridgeNetworkCidr,DockerHttpProxy,DockerHttpsProxy,DockerNoProxy,AdminState,ServiceTicketReceipient,DnsDomainName,DnsServers,TargetPlatform,ServerAssignmentMode,Qualifier,Selectors,PolicyBucket,ResourceGroups"
    imc_access = ",AddressType,ConfigurationType,InbandIpPool,InbandVlan,OutOfBandIpPool"
    smtp = ",MinSeverity,SenderEmail,SmtpPort,SmtpRecipients,SmtpServer"
    vmedia = ",Mappings,Encryption,LowPowerUsb"
    kvm = ",EnableLocalServerVideo,EnableVideoEncryption,MaximumSessions,RemotePort"
    eth_adapter = ",AdvancedFilter,ArfsSettings,CompletionQueueSettings,GeneveEnabled,InterruptScaling,InterruptSettings,NvgreSettings,RoceSettings,RssHashSettings,RssSettings,RxQueueSettings,TxQueueSettings,UplinkFailbackTimeout,VxlanSettings,TcpOffloadSettings"
    eth_net = ",VlanSettings"
    eth_qos = ",Mtu,RateLimit,Cos,Burst,Priority,TrustHostCos"
    eth_net_control = ",CdpEnabled,MacRegistrationMode,UplinkFailAction,ForgeMac,LldpSettings"
    ipmi = ",Privilege"
    ip_pool = ",IpV4Blocks,IpV4Config,IpV6Blocks,IpV6Config"
    mac_pool = ",MacBlocks"
    uuid_pool = ",Prefix,Size,UuidSuffixBlocks"
    iqn_pool = ",IqnSuffixBlocks"
    fc_pool = ",IdBlocks,PoolPurpose"
    if url != "bios/Policies":
        URL = f"{base_url}{url}?{expand_url}&{select_url}{imc_access}{smtp}{vmedia}{kvm}{eth_adapter}{eth_net}{eth_qos}{eth_net_control}{ipmi}{ip_pool}{mac_pool}{uuid_pool}{iqn_pool}{fc_pool}"
    if url == "bios/Policies":
        URL = f"{base_url}{url}?{expand_url}"
    payload = {}
    headers = {"Accept": "application/json"}
    response = requests.request(
        "GET", url=URL, auth=auth, headers=headers, data=payload
    )
    return response.json()


def get_urls(filename):
    """
    Function to load file with Intersight URL's.
    """
    with open(filename, "r") as f:
        urls = json.load(f)
    return urls


def main():
    """
    Main Function to execute the script
    """
    # Load URL file
    url_file = "intersight_urls.json"
    urls = get_urls(url_file)

    # Make API calls to all the URL's
    intersight_objects = {}
    for key, value in urls.items():
        print(key)
        response = get_object(urls[key])
        intersight_objects[key] = response["Results"]

    parsed_data = {}
    for key in intersight_objects.keys():
        if len(intersight_objects[key]) != 0:
            parsed_data[key] = intersight_objects[key]
    # Write response to a json.
    with open("intersight_objects.json", "w") as f:
        json.dump(parsed_data, f)

if __name__ == "__main__":
    main()
