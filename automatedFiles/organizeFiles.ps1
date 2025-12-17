$downloadedDir = "~\Downloads"

$files = Get-ChildItem -Path $downloadedDir -File

$files | ForEach-Object{
    $file = $_
    $fileName = $file.Name
    $fileExtension = $file.Extension
    Write-Host "File Name: $fileName, File Extension: $fileExtension"
}