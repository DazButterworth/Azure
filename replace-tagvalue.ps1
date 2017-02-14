#Login-AzureRmAccount

$tag = "SRID"
$value = "Automated"
$value_new = "Portal Build"
$VMs = Get-AzureRmVM
ForEach ($VM in $VMs)
    {
    #$vm.name
    #$vm.Tags | Format-Table
    #$vm.Tags[$tag]
    $tags = $vm.Tags
    if ($tags[$tag] -eq $value)
        {
        $ResGroupVM = $vm.ResourceGroupName
        write-host($vm.Name + "`t" + $tags[$tag])
        $tags.remove($tag)
        $tags.add($tag,$value_new)
        write-host($vm.Name + "`t" + $tags[$tag])
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    write-host
    }
