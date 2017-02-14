# This script replaces the value of a specified Tag when it currently contains a specified value

param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Tag to be updated. eg: ./replace-tagvalue.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$Tag = "SRID",
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Current Tag Value. eg: ./replace-tagvalue.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$CurrentValue = "Manual Build",
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "New Tag Value. eg: ./replace-tagvalue.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$NewValue = "Automated"
)


#Uncomment if AZureRM module not already installed
#Import-module AzureRM

#To logon & connect to Azure
#Login-AzureRmAccount

$vms = Get-AzureRmVM

ForEach ($vm in $vms)
    {
    #$vm.name
    #$vm.Tags | Format-Table
    #$vm.Tags[$tag]
    $tags = $vm.Tags
    if ($tags[$Tag] -eq $CurrentValue)
        {
        $ResGroupVM = $vm.ResourceGroupName
        write-host($vm.Name + "`t" + $tags[$Tag])
        $tags.remove($Tag)
        $tags.add($Tag,$NewValue)
        write-host($vm.Name + "`t" + $tags[$Tag])
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    write-host
    }
