$to = "to@gmail.com"
$from = "from@gmail.com"
$subject = "Files structures"
$smtp_server = "sandbox.smtp.mailtrap.io"

$files_dir = "C:\PowerShell\github\zip_old_files\tmp_files\"

$out_csv_path = "files_info.csv"

$files = Get-ChildItem -Path $files_dir -File

$files_info = @()

foreach ($file in $files) {
    $full_name = $file.FullName
    $write_time = $file.CreationTime
    $access_time = $file.LastAccessTime
    $files_info += [PSCustomObject]@{
        Name     = $full_name
        Created  = $write_time
        Accessed = $access_time
    }
}

$files_info | Export-Csv -Path $out_csv_path -NoTypeInformation -Force

Send-MailMessage  -To $to -From $from -Subject  $subject -SmtpServer $smtp_server -UseSsl -Port  2525 -Credential (New-Object System.Management.Automation.PSCredential("77f2c9928e8c04", $(ConvertTo-SecureString "3e42209e8e2bcc" -AsPlainText -Force)))  -Body  "Please find attached csv file that contains files structure information" -Attachment  $out_csv_path

