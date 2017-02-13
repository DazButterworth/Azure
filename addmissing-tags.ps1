#Login-AzureRmAccount
$newTag1 = "BillTo"
$newValue1 = "N/A"
$newTag2 = "SRID"
$newValue2 = "Manual Build"
$newTag3 = "dataClassification"
$newValue3 = "Internal"
$VMs = Get-AzureRmVM
ForEach ($VM in $VMs)
    {
    #$vm.name
    #$vm.Tags.Count
    #$vm.Tags | ft
    if ($vm.Tags.Count -eq 12)
        {
        $ResGroupVM = $vm.ResourceGroupName
        $tags = $vm.Tags
        #$vm.Name
        #$tags | ft
        write-host($vm.Name + "`t" + $tags.count)
        $tags.add($newTag1,$value1)
        $tags.add($newTag2,$value2)
        $tags.add($newTag3,$value3)
        write-host($vm.Name + "`t" + $tags.count)
        # Comment out the line below to test Tag matches and success reporting before committing to changes
        #Set-AzureRmResource -ResourceGroupName $ResGroupVM -Name $vm.Name -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force
        }
    write-host
    }

