PARAM(
    [string]$VMname = 'blah'
)

$int = 1

Do{
    if ($int % 2 -eq 0)
        {write-host "-"}
    else
        {write-host "|"}
    $int++
    $dnsentry = resolve-dnsname $VMname -ErrorAction silentlycontinue
} while ($dnsentry -eq $null)

write-host "Name resolves now"