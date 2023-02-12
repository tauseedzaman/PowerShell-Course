function  Generate_Password {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Count,
        [Parameter(Mandatory=$true)]
        [int]$Length
    )

    # chars for random password
    $chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"

    # loop thro no of password to generate
    for ($i = 0; $i -lt $Count; $i++) {
        $password=""
        for ($j = 0; $j -lt $Length; $j++) {
            $random_index=Get-Random -Minimum 0 -Maximum ($chars.Length-1)
            $password +=$chars[$random_index]
        }
        Write-Host $password
    }
}

$no_of_password=Read-Host "Enter No of passwords to generate"
$length_of_password=Read-Host "Enter passwords length"
if ((-not $no_of_password) -or (-not $length_of_password)) {
    Write-Warning "Invalid Entry"
    exit 0
}
Generate_Password -Count $no_of_password -Length $length_of_password
