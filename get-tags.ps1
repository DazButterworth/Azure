#This script provides all or specified tags for all or specified VMs

#If VM Names aren't specified tags for all VMs are returned.
#If Tag isn't specified all are returned, or if a default value for $Tag
# has been defined then that tag will be returned.

param(
    [Parameter(
        Mandatory=$false,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "One or more computer names, separated by commas, followed by a space and then the Resource Group Name"
    )]
    [string[]]$VMNames,
    [string]$Tag,
    [string]$ResGroupVM = "SS-INFRA-PROD-EUN-RG"
)

#Uncomment if AZureRM module not already installed
#Import-module AzureRM

#To logon & connect to Azure
#Login-AzureRmAccount

#For formating purposes only
Write-Host

if ($VMNames -eq $null)
    {
    $VMs = Get-AzureRmVm
    #$VMs = Get-AzureRmStorageAccount
    #Step through each VMName provided
    ForEach ($VM in $VMs){
        #Display Name and Tags
        $vm.Name
        if ($Tag) # list a specific tag
            {
            $VM.tags[$tag]
            }
        else # specific tag not specified so list all
            {
            $VM.tags | Format-Table
            }
        }
    }
else
    {
    #Step through each VMName provided
    ForEach ($VMName in $VMNames){
       #Get VM as an object
       $vm = get-azurermvm -name $VMName -resourcegroupname $ResGroupVM -WarningAction SilentlyContinue
       if ($Tag -eq "") # specific tag not specified so list all
            {
            $vm.Tags | Format-Table
            }
        else # list a specific tag
            {
            $vm.tags[$tag]
            }
        }
    }



