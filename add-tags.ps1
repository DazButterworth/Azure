# This script adds standard tags to resources which don't currently have tags assigned

#Uncomment if AZureRM module not already installed
#Import-module AzureRM

#To logon & connect to Azure
#Login-AzureRmAccount

# define tags
$newTag01 = "authoriser"
$value01 = "N/A"
$newTag02 = "bFunction"
$value02 = "N/A"
$newTag03 = "bUnit"
$value03 = "N/A"
$newTag04 = "billTo"
$value04 = "N/A"
$newTag05 = "cc"
$value05 = "N/A"
$newTag06 = "cer"
$value06 = "N/A"
$newTag07 = "dataClassification"
$value07 = "N/A"
$newTag08 = "environment"
$value08 = "N/A"
$newTag09 = "managedBy"
$value09 = "N/A"
$newTag10 = "nominalLedger"
$value10 = "N/A"
$newTag11 = "projectNum"
$value11 = "N/A"
$newTag12 = "reqDate"
$value12 = "N/A"
$newTag13 = "requestor"
$value13 = "N/A"
$newTag14 = "serviceName"
$value14 = "N/A"
$newTag15 = "SRID"
$value15 = "N/A"


#For formating purposes only
Write-Host

#$VMs = Get-AzureRmVm
#$vms = Get-AzureRmStorageAccount
#$vms = Get-AzureRmAvailabilitySet -ResourceGroupName "ss-infra-prod-eun-rg"
$vms = Get-AzureRmNetworkInterface

ForEach ($VM in $VMs)
    {
    #Display Name and Tags
    $vm.Name
    #Storage Account uses different property for name
    #$vm.StorageAccountName
    #$vm.Tags.Count
    #$vm.Tags | ft

    #if ($vm.Tags.Count -eq 0)
    #NIC uses singular property
    if ($vm.Tag.Count -eq 0)
        {
        $ResGroupVM = $vm.ResourceGroupName
        #populate with current tags
        #$tags = $vm.Tags
        #NIC uses singular property
        #$tags = $vm.Tag
        #create empty hash table when count is 0
        $tags = @{}
        
        #$vm.Name
        #$tags | ft
        write-host($vm.Name + "`t" + $tags.count)
        #Storage Account uses different property for name
        #write-host($vm.StorageAccountName + "`t" + $tags.count)
        
        $tags.add($newTag01,$value01)
        $tags.add($newTag02,$value02)
        $tags.add($newTag03,$value03)
        $tags.add($newTag04,$value04)
        $tags.add($newTag05,$value05)
        $tags.add($newTag06,$value06)
        $tags.add($newTag07,$value07)
        $tags.add($newTag08,$value08)
        $tags.add($newTag09,$value09)
        $tags.add($newTag10,$value10)
        $tags.add($newTag11,$value11)
        $tags.add($newTag12,$value12)
        $tags.add($newTag13,$value13)
        $tags.add($newTag14,$value14)
        $tags.add($newTag15,$value15)
        
        write-host($vm.Name + "`t" + $tags.count)
        #Storage Account uses different property for name
        #write-host($vm.StorageAccountName + "`t" + $tags.count)

        #Comment out the line below to test Tag matches and success reporting before committing to changes
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.StorageAccountName -ResourceType "Microsoft.Storage/StorageAccounts" -Tag $tags -Force
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/AvailabilitySets" -Tag $tags -Force
        Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Network/NetworkInterfaces" -Tag $tags -Force
        }
    write-host
    }

