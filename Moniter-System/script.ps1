$storeFile = "result.csv"

$RAM = Get-WMIObject Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | % { $_.sum / 1Mb }

$tmp = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process |
select-object -Property Name, @{
    Name = "CPU(s)"; Expression = { 
        $p_id = $_.IDProcess; 
        if (($cpu = (Get-Process | Where-Object { $_.Id -like $p_id } | Select-Object CPU).CPU) -ne $null) {
            ([math]::Round($cpu, 2))
        }
        else {
            0
        }
    } 
}, 
@{
    Name = "PID"; Expression = { $_.IDProcess } 
}, 
@{
    Name = "Memory(MB)"; Expression = { [int]($_.WorkingSetPrivate / 1mb) } 
}, 
@{
    Name = "Memory(%)"; Expression = { ([math]::Round(($_.WorkingSetPrivate / 1Mb) / $RAM * 100, 2)) } 
}, 
@{
    Name = "Disk(MB)"; Expression = { [Math]::Round(($_.IODataOperationsPersec), 2) } 
}, 
@{
    Name = "Network"; Expression = { $_.IOReadBytesPersec } 
}, 
@{
    Name = "TimeStamp"; Expression = { Get-Date } 
} |
Where-Object { $_.Name -notmatch "^(idle|_total|system)$" } |
Sort-Object -Property CPU -Descending

# import to csv
foreach ($item in $tmp) {
    if ($item."CPU(s)" -gt 0) {
        [PSCustomObject]@{
            Name         = $item.Name
            "CPU(s)"     = $item."CPU(s)"
            "Memory(MB)" = $item."Memory(MB)"
            "Memory(%)"  = $item."Memory(%)"
            "Disk(MB)"   = $item."Disk(MB)"
            Network      = $item."Network"
            TimeStamp    = $item."TimeStamp"
        } | Export-Csv $storeFile -Append -NoTypeInformation -Force
    }
}

# display to terminal
$tmp | Where-Object { $_."CPU(s)" -gt 0 } | Format-Table -Autosize -Property Name, "CPU(s)", PID, "Memory(MB)", "Memory(%)", "Disk(MB)", "Network", TimeStamp;