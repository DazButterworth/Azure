# This script replaces a certain value with a new value on a specified Azure VM Tag

param(
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Tag to be updated. eg: ./update-tag.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$Tag,
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "Old Value. eg: ./update-tag.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$OldValue,
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline =$true,
        ValueFromPipelineByPropertyName =$true,
        HelpMessage = "New Value. eg: ./update-tag.ps1 nominalLedger fdssdfsfd 4444"
    )]
    [string]$NewValue
)

#To logon & connect to Azure
Login-AzureRmAccount

#Include if module not already installed - takes time to load
# Import-module AzureRM

#Tags are updated as a single object. To add a tag to a resource that already includes tags,
#first retrieve the existing tags. Add the new tag to the object that contains the existing tags,
#and reapply all the tags to the resource.

#Get all VMs in Azure
$VMs = Get-AzureRmVM

#Step through each VM
ForEach ($VM in $VMs)
    {
    #Get individual VM's tags
    $tags = $VM.Tags
    #Check to see if specified Tag has specified Value
    if ($tags[$Tag] -match $OldValue)
        {
        $VMName = $VM.Name
        $ResGroupVM = $VM.ResourceGroupName
        #For formatting only
        Write-Host
        #Display VM and current Tag Value
        write-host($VMName + "`t" + $tags[$Tag])
        #Remove whole Tag not just Value
        $tags.remove($Tag)
        #Re-add Tag but with new Value
        #$tags.add($Tag,$NewValue)
        $tags.add("nominalLedger",$NewValue)
        #Display New Tag Value
        write-host($VMName + "`t" + $tags[$Tag])
        #Following command applies the asjusted tags in one go
        #Comment next line out to test which VMs are selected and to check Tag gets updated and, only then, remove the comment
        Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $VMName  -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    }


