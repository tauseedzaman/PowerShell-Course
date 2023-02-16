$files_dir=".\tmp_files"
$days=60
$output_zip_file_name="files_older_then_$days.zip"

$older_files=Get-ChildItem -Path $files_dir | Where-Object {
    $_.LastWriteTime -lt (Get-Date).AddDays(-$days)
}
Compress-Archive -Path $older_files.FullName -DestinationPath "$output_zip_file_name"


Write-Host "zip archive created in $output_zip_file_name"
