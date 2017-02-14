#This script replaces a current Tag name with a new Tag name, whilst maintaining the current $value

param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Tag to be updated. eg: ./update-tag.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$oldTag = "BillTo",
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Old Value. eg: ./update-tag.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$newTag = "billTo"
)

#Uncomment if AZureRM module not already installed
#Import-module AzureRM

#To logon & connect to Azure
#Login-AzureRmAccount

$vms = Get-AzureRmVM

ForEach ($vm in $vms)
    {
    #$vm.name
    #$vm.ResourceGroupName
    #$vm.Tags | ft
    if ($vm.Tags[$oldTag])
        {
        $ResGroupVM = $vm.ResourceGroupName
        $tags = $vm.Tags
        $value = $tags[$oldTag]
        write-host($vm.Name + "`t" + $value)
        $tags.remove($oldTag)
        $tags.add($newTag,$value)
        write-host($vm.Name + "`t" + $tags[$newTag])
        # Comment out the line below to test Tag matches and success reporting before committing to changes
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    write-host
    }

