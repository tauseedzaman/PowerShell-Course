$start_date=Get-Date "2022-01-01"
$end_date=Get-Date "2023-02-11"

$days = ($end_date - $start_date).Days

$dir_path=".\tmp_files"

$files = Get-ChildItem -Path $dir_path -File

foreach($file in $files){
    $random_days=Get-Random -Minimum 0 -Maximum $days
    $random_date = $start_date.AddDays($random_days)
    $format_date = $random_date.ToString("yyyy-MM-dd")
    Set-ItemProperty -Path $file.FullName -Name LastWriteTime -Value $format_date
}