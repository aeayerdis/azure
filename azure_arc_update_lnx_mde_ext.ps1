# Updates the Linux MDE Extension that is pushed out via Defender for Cloud automagically once onboarded through Azure ARC.

# Authenticate to Azure
Connect-AzAccount

# Specify the Subscription you wish to work in
Set-AzContext -Subscription "SUB_ID"

# Creates object variable of all resource groups in your subscription. In my case, I have a subscription dedicated to Azure ARC for on-prem servers
$resource_groups = Get-AzResourceGroup

# Iterates through the Resource Group to grab Linux servers that are managed via Azure ARC
foreach ($rg in $resource_groups.ResourceGroupName){
$grab_hosts = Get-AzConnectedMachine -ResourceGroupName $rg
$successful = $grab_hosts | Where-Object {$_.Status -ceq "Connected"}
$lnx_online_hosts = $successful | Where-Object {$_.OSType -ceq "linux"}

# Specifies the Extension and Version of Extension to update to
$target = @{"Microsoft.Azure.AzureDefenderForServers.MDE.Linux" = @{"targetVersion"="W.X.Y.Z"}}

# Nested loop to iterate through the resource groups and Linux hosts within those RGs to update the extensions
    foreach ($name in $lnx_online_hosts.Name){
    $update_mde_lnx = Update-AzConnectedExtension -ResourceGroupName $rg -MachineName $name -ExtensionTarget $target -NoWait
    $update_mde_lnx
    }

}
