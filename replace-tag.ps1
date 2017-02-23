#This script replaces a current Tag name with a new Tag name, whilst maintaining the current $value

param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Tag to be updated. eg: ./replace-tag.ps1 SR SRID"
    )]
    [string]$oldTag,
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Old Value. eg: ./replace-tag.ps1 SR SRID"
    )]
    [string]$newTag
)

#Uncomment if AZureRM module not already installed
#Import-module AzureRM

#To logon & connect to Azure
#Login-AzureRmAccount

#$vms = Get-AzureRmVM
#$vms = Get-AzureRmStorageAccount
#$vms = Get-AzureRmAvailabilitySet -ResourceGroupName "ss-infra-prod-eun-rg"
$vms = Get-AzureRmNetworkInterface

ForEach ($vm in $vms)
    {
    #$vm | gm
    $vm.name
    #$vm.tag
    $vm.ResourceGroupName
    #$vm.Tags | ft
    
    #if ($vm.Tags[$oldTag])
    if ($vm.Tag[$oldTag]) #NIC uses singular property
        {
        $ResGroupVM = $vm.ResourceGroupName
        #$tags = $vm.Tags
        $tags = $vm.Tag #NIC uses singular property
        $value = $tags[$oldTag]
        write-host($vm.Name + "`t" + $value)
        $tags.remove($oldTag)
        $tags.add($newTag,$value)
        write-host($vm.Name + "`t" + $tags[$newTag])
        #write-host($vm.StorageAccountName + "`t" + $tags[$newTag])

        # Comment out the line below to test Tag matches and success reporting before committing to changes
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.StorageAccountName -ResourceType "Microsoft.Storage/StorageAccounts" -Tag $tags -Force
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/AvailabilitySets" -Tag $tags -Force
        Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Network/NetworkInterfaces" -Tag $tags -Force
        }
    write-host
    }

