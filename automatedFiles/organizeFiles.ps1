$downloadedDir = "~\Downloads"

$files = Get-ChildItem -Path $downloadedDir -File

$imageExtensions = @(".jpg", ".jpeg", ".png", ".gif")
$documentExtensions = @(".pdf", ".docx", ".txt")
$videoExtensions = @(".mp4", ".mov")
$compressedExtensions = @(".zip", ".rar")

if (-not (Test-Path -Path "~\Downloads\Images")){
    New-Item -ItemType Directory -Path "~\Downloads\Images"
}
if (-not (Test-Path -Path "~\Downloads\Documents")){
    New-Item -ItemType Directory -Path "~\Downloads\Documents"
}
if (-not (Test-Path -Path "~\Downloads\Videos")){
    New-Item -ItemType Directory -Path "~\Downloads\Videos"
}
if (-not (Test-Path -Path "~\Downloads\Compressed")){
    New-Item -ItemType Directory -Path "~\Downloads\Compressed"
}
if (-not (Test-Path -Path "~\Downloads\Other")){
    New-Item -ItemType Directory -Path "~\Downloads\Other"
}

$files | ForEach-Object{
    $file = $_
    $fileName = $file.Name.ToLower()
    $fileExtension = $file.Extension.ToLower()

    if ($imageExtensions -contains $fileExtension){
        Write-Host "Image File: $fileName"
        Move-Item -Path $file.FullName -Destination "~\Downloads\Images\$fileName" 
    } 
    elseif ($documentExtensions -contains $fileExtension){
        Write-Host "Document File: $fileName"
        Move-Item -Path $file.FullName -Destination "~\Downloads\Documents\$fileName" 
    } 
    elseif ($videoExtensions -contains $fileExtension){
        Write-Host "Video File: $fileName"
        Move-Item -Path $file.FullName -Destination "~\Downloads\Videos\$fileName" 
    } 
    elseif ($compressedExtensions -contains $fileExtension){
        Write-Host "Compressed File: $fileName"
        Move-Item -Path $file.FullName -Destination "~\Downloads\Compressed\$fileName" 
    } else {
        Write-Host "Unknown File Type: $fileName"
        Move-Item -Path $file.FullName -Destination "~\Downloads\Other\$fileName"
    }
}