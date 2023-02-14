# target dir that will be organized
$folder_path=".\tmp_files"


# available files extentions that will be organized
$extentions=@(
    @{Extention=".png"; subFolder="PNG"},
    @{Extention=".txt"; subFolder="txr"},
    @{Extention=".html"; subFolder="HTML"},
    @{Extention=".js"; subFolder="JS"},
    @{Extention=".css"; subFolder="CSS"},
    @{Extention=".php"; subFolder="PHP"},
    @{Extention=".py"; subFolder="Py"},
    @{Extention=".docx"; subFolder="DOCS"},
    @{Extention=".ppt"; subFolder="PPT"},
    @{Extention=".xls"; subFolder="XLS"}
)

Get-ChildItem $folder_path | ForEach-Object {
    if ($_.PSIsContainer -eq $false) {
        $ext = $_.Extension
        $match = $extentions | Where-Object { $_.Extention -eq $ext }
        if ($match) {
            $sub_folder=Join-Path $folder_path $match.subFolder
            if (!(Test-Path $sub_folder)) {
                New-Item -ItemType Directory $sub_folder | Out-Null
            }
            Move-Item $_.FullName $sub_folder
        }
    }