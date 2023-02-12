$csv_file_path = ".\data.csv"

function Add-Record {
    param(
        [parameter(Mandatory = $true)][string]$Name,
        [parameter(Mandatory = $true)][int]$Age
    )
    $data = [PSCustomObject]@{
        Name = $name
        Age  = $age
    }
    $data | Export-Csv -Path $csv_file_path -NoTypeInformation -Force -Append
}

function Update-Record {
    param(
        [parameter(Mandatory = $true)][string]$Name,
        [parameter(Mandatory = $true)][string]$Existing,
        [parameter(Mandatory = $true)][int]$Age
    )
    $data = Import-Csv -Path $csv_file_path
    $data | ForEach-Object {
        if ($_.Name -eq $Existing) {
            $_.Name = $Name
            $_.Age = $Age
        }
    }
    $data | Export-Csv -Path $csv_file_path -NoTypeInformation -Force

}

function Delete-Record {
    param(
        [parameter(Mandatory = $true)][string]$Name
    )
    $data = Import-Csv -Path $csv_file_path
    $new_data = $data | Where-Object { $_.Name -ne $Name }
    $new_data | Export-Csv -Path $csv_file_path -NoTypeInformation -Force

}

function Read-Records {
    $data = Import-Csv -Path $csv_file_path
    $counter = 0;
    $new_data = $data | Foreach-Object { 
        Write-Host "$($counter), Name:$($_.Name), Age:$($_.Age)"
        $counter++
    }
}
function Read-Single-Record {
    param(
        [parameter(Mandatory = $true)][string]$Name
    )
    $data = Import-Csv -Path $csv_file_path
    $data | ForEach-Object {
        if ($_.Name -eq $Name) {
            Write-Host "Name:$($_.Name), Age:$($_.Age)"
        }
    }
}