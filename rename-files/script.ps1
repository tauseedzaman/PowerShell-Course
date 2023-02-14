$source_files = "C:\PowerShell\github\random-files-generator\tmp_files"
$dist_path = "renamed_files"
$prepend_string = "MyFiles__"

if (!(Test-Path $dist_path)) {
    New-Item -ItemType Directory $dist_path
}

$files_list = gci -Path $source_files

foreach ($file in $files_list) {
    $newFileName = $prepend_string + $file.name
    $new_file_path = Join-Path -Path $dist_path -ChildPath $newFileName
    Move-Item $file.FullName $new_file_path
}
Write-Host "files renamed to $dist_path"