#!/usr/bin/env python3
import requests
import json

from intersight_auth import IntersightAuth


def get_object(url):
    """
    Function to make HTTP GET API calls to Intersight and return response in json.
    """
    auth = IntersightAuth(
        secret_key_filename="./SecretKey.txt",
        api_key_id="<replace_with_api_key_id>"
        # api_key_id=os.getenv("api_key_id"),
    )
    base_url = "https://intersight.com/api/v1/"

    expand_url = "$expand=Organization($select=Name),Profiles($select=Name),ClusterProfiles($select=Name)"
    select_url = "$select=Name,Tags,Description,Organization,Profiles,Settings,ConfiguredBootMode,EnforceUefiSecureBoot,BootDevices,LockoutEnabled,Partitions,BaudRate,ComPort,Enabled,SshPort,MinSeverity,SenderEmail,SmtpPort,SmtpRecipients,SmtpServer,Port,Timeout,GlobalHotSpares,M2VirtualDrive,Raid0Drive,UnusedDisksState,UseJbodForVdCreation,DriveGroup,EnableLocalServerVideo,EnableVideoEncryption,MaximumSessions,RemotePort,Mappings,Encryption,LowPowerUsb,CdpEnabled,ForgeMac,LldpSettings,MacRegistrationMode,UplinkFailAction,NetworkPolicy,VlanSettings,PriorityFlowControlMode,ReceiveDirection,SendDirection,LacpRate,SuspendIndividual,UdldSettings,QuerierIpAddress,QuerierIpAddressPeer,QuerierState,SnoopingState,AlternateIpv4dnsServer,AlternateIpv6dnsServer,DynamicDnsDomain,EnableDynamicDns,EnableIpv4dnsFromDhcp,EnableIpv6,EnableIpv6dnsFromDhcp,PreferredIpv4dnsServer,,PreferredIpv6dnsServer,NtpServers,Timezone,EthernetSwitchingMode,FcSwitchingMode,MacAgingSettings,VlanPortOptimizationEnabled,RemoteClients,LocalClients,Classes,AddressType,ConfigurationType,InbandVlan,InbandIpPool,OutOfBandIpPool,PowerProfiling,PowerRestoreState,RedundancyMode,AllocatedBudget,AccessCommunityString,CommunityAccess,EngineId,SnmpPort,SnmpTraps,SnmpUsers,SysContact,SysLocation,TrapCommunity,V2Enabled,V3Enabled,FanControlMode,AddonConfiguration,AddonDefinition,ClusterProfiles,DockerBridgeNetworkCidr,DockerHttpProxy,DockerHttpsProxy,DockerNoProxy,AdminState,ServiceTicketReceipient,DnsDomainName,DnsServers"
    if url != "bios/Policies":
        URL = f"{base_url}{url}?{expand_url}&{select_url}"
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

    # Write response to a json.
    with open("intersight_objects.json", "w") as f:
        json.dump(intersight_objects, f)

if __name__ == "__main__":
    main()
