$Extentions=@(".png", ".txt", ".html", ".js", ".css", ".php", ".py", ".docx", ".ppt", ".xls")
$file_count=100
$dist_path=".\tmp_files"


if (!(Test-Path -Path $dist_path)) {
    New-Item -ItemType Directory -Path $dist_path
}

for ($i = 0; $i -lt $file_count; $i++) {
    $file_name = -join ((65..90) + (97..122) | Get-Random -Count 18 | % {[char]$_})
    $ext = $Extentions[(Get-Random -Minimum 0 -Maximum ($Extentions.Count - 1))]
    $path = Join-Path -Path $dist_path -ChildPath "$file_name$ext"
    New-Item -ItemType File -Path $path
}

Write-Host "$file_count random files created in $dist_path"