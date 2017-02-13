#Login-AzureRmAccount
$oldTag = "SR"
$newTag = "SRID"
$VMs = Get-AzureRmVM
ForEach ($VM in $VMs)
    {
    $vm.name
    $vm.Tags.Count
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

