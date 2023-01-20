# Basic loop to iterate through tables in Log Analytics Workspace to increase the retention period for hot and archival storage.
# Running the Get-AzOperationalInsightsTable will grab over 400 tables which is doable if thats what you want for the entire environment
# This script defines a tables list of the tables used for Microsoft Sentinel Log Analytics Workspace. You can edit the variable to include your list of custom tables

#Connect to Azure Account
Connect-AzAccount

# Defines your Subscription to work out of 
Set-AzContext -Subscription "SUB_ID"

# You have two options. Option 1 is to make the update to all 400+ tables available in a log analytics workspace. Option 2 is to manually define the tables you wish to work with

# If you want to grab all 400+ tables you can get them in a object variable
$get_tables = Get-AzOperationalInsightsTable -ResourceGroupName $rg -WorkspaceName $ws

# Loop through the table names to increase the hot/archival rentention periods
foreach ($table in get_tables.Name){
$update_tables = Update-AzOperationalInsightsTable -ResourceGroupName $rg -WorkspaceName $ws  -TableName $table -RetentionInDays 90 -TotalRetentionInDays 365
$update_tables
}

# Manually Defines Table for what is in use
$tables = 'NetworkSessions','AADManagedIdentitySignInLogs','WindowsFirewall','SecurityIncident','UserPeerAnalytics','UserAccessAnalytics','UpdateSummary','Update','SysmonEvent','SecurityRegulatoryCompliance','SecurityRecommendation','SecurityEvent','SecurityDetection','SecurityBaselineSummary','SecurityBaseline','SecurityAlert','SecureScores','SecureScoreControls','ProtectionStatus','LinuxAuditLog','IdentityInfo','CommonSecurityLog','BehaviorAnalytics','WindowsEvent','Watchlist','VMProcess','VMConnection','VMComputer','VMBoundPort','Usage','UrlClickEvents','ThreatIntelligenceIndicator','Syslog','SigninLogs','SentinelHealth','SentinelAudit','ProjectActivity','PowerBIActivity','Operation','OfficeActivity','NetworkMonitoring','MicrosoftPurviewInformationProtection','McasShadowItReporting','KubeServices','KubePodInventory','KubeNodeInventory','KubeMonAgentEvents','KubeMonAgentEvents','KubeEvents','InsightsMetrics','IdentityQueryEvents','IdentityLogonEvents','IdentityDirectoryEvents','HuntingBookmark','Heartbeat','GCPAuditLogs','Event','EmailUrlInfo','EmailPostDeliveryEvents','EmailEvents','EmailAttachmentInfo','DynamicSummary','DnsInventory','Dynamics365Activity','DnsEvents','DeviceTvmSoftwareVulnerabilities','DeviceTvmSoftwareInventory','DeviceTvmSecureConfigurationAssessment','DeviceRegistryEvents','DeviceProcessEvents','DeviceNetworkInfo','DeviceNetworkEvents','DeviceLogonEvents','DeviceInfo','DeviceImageLoadEvents','DeviceFileEvents','DeviceFileCertificateInfo','DeviceEvents','ContainerServiceLog','ContainerNodeInventory','ContainerLog','ContainerInventory','ContainerImageInventory','ConfidentialWatchlist','ComputerGroup','CloudAppEvents','AzureMetrics','AzureDiagnostics','AWSVPCFlow','AWSGuardDuty','AWSCloudWatch','AWSCloudTrail','AuditLogs','ASimNetworkSessionLogs','ASimDnsActivityLogs','AppCenterError','Anomalies','AlertInfo','AlertEvidence','Alert','AADUserRiskEvents','AADServicePrincipalSignInLogs','AADRiskyUsers','AADProvisioningLogs','AADNonInteractiveUserSignInLogs','AADNonInteractiveUserSignInLogs'

# Loop through the table names to increase the hot/archival rentention periods
foreach ($table in $tables){
$update_tables = Update-AzOperationalInsightsTable -ResourceGroupName $rg -WorkspaceName $ws  -TableName $table -RetentionInDays 90 -TotalRetentionInDays 365
$update_tables
}
