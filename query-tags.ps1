#Login-AzureRmAccount

$VMs = Get-AzureRmVM
ForEach ($VM in $VMs)
    {
    #$vm.name
    #$vm.Tags | ft
    if ($vm.Tags['NominalLedger'])
        {
        $ResGroupVM = $vm.ResourceGroupName
        $tags = $vm.Tags
        $value = $tags['NominalLedger']
        write-host($vm.Name + "`t" + $value)
        $tags.remove("NominalLedger")
        $tags.add("nominalLedger",$value)
        write-host($vm.Name + "`t" + $tags["nominalLedger"])
        Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    write-host
    }

