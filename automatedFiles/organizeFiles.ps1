$downloadedDir = "~\Downloads"

$files = Get-ChildItem -Path $downloadedDir -File

$imageExtensions = @(".jpg", ".jpeg", ".png", ".gif")
$documentExtensions = @(".pdf", ".docx", ".txt")
$videoExtensions = @(".mp4", ".mov")

if (-not (Test-Path -Path "~\Downloads\Images")){
    New-Item -ItemType Directory -Path "~\Downloads\Images"
}
if (-not (Test-Path -Path "~\Downloads\Documents")){
    New-Item -ItemType Directory -Path "~\Downloads\Documents"
}
if (-not (Test-Path -Path "~\Downloads\Videos")){
    New-Item -ItemType Directory -Path "~\Downloads\Videos"
}

$files | ForEach-Object{
    $file = $_
    $fileName = $file.Name
    $fileExtension = $file.Extension
    if ($imageExtensions -contains $fileExtension){
        Write-Host "Image File: $fileName"
    } elseif ($documentExtensions -contains $fileExtension){
        Write-Host "Document File: $fileName"
    } elseif ($videoExtensions -contains $fileExtension){
        Write-Host "Video File: $fileName"
    } else {
        Write-Host "Unknown File Type: $fileName"
    }
}