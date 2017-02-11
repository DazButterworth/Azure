
param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "One or more computer names, separated by commas, followed by a space and then the Resource Group Name"
    )]
    [string[]]$VMNames,
    [string]$ResGroupVM = "SS-INFRA-PROD-EUN-RG"
)

#Import-module AzureRM

#To logon & connect to Azure
Login-AzureRmAccount

#For formating purposes only
Write-Host

#Step through each VMName provided
ForEach ($VMName in $VMNames){
    #Get VM as an object
    $vm = get-azurermvm -name $VMName -resourcegroupname $ResGroupVM -WarningAction SilentlyContinue
    
    #Display Name and Tags
    $vm.Name
    $vm.Tags | Format-Table
    
    #To list a specific tag
    # $vm.tags['billTo']
}
