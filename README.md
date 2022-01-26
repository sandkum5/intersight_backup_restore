# intersight_backup_restore
- Repo to backup Orgs, Policies, Pools, Profiles etc using Python.
- Create the objects under a different account or recreate in the same account using Terraform.

### WORKFLOW
- Get existing objects using Python.
- Parse returned data in intersight_objects.json using Python to create the intersight_parsed.tfvars.json file.
- intersight_parsed.tfvars.json file is used to recreate the objects using Terraform.

### Following Objects workflow exists
`Policies`
- BIOS
- DC(Device Connector)
- Ethernet Adapter
- Ethernet Network Control
- Ethernet Network Group
- Ethernet Network
- Ethernet QoS
- IMC Access
- IPMI
- LAN Connectivity(Work in Progress)
- NTP
- SMTP
- SOL
- SSH
- Syslog
- VIC Adapter
- vKVM
- vMedia

`Pools`
- FC(WWPN, WWNN)
- IQN
- MAC
- UUID
- IP

`Profiles`
- Server (Work in Progress)
