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
        try {
            Move-Item -Path $file.FullName -Destination "~\Downloads\Images\$fileName" -ErrorAction Stop
        } catch {
            Write-Host "Error moving image file: $fileName, it is likely a duplicate or same name"
        }
    } 
    elseif ($documentExtensions -contains $fileExtension){
        Write-Host "Document File: $fileName"
        try {
            Move-Item -Path $file.FullName -Destination "~\Downloads\Documents\$fileName" -ErrorAction Stop
        } catch {
            Write-Host "Error moving document file: $fileName, it is likely a duplicate or same name"
        }
    } 
    elseif ($videoExtensions -contains $fileExtension){
        Write-Host "Video File: $fileName"
        try {
            Move-Item -Path $file.FullName -Destination "~\Downloads\Videos\$fileName" -ErrorAction Stop
        } catch {
            Write-Host "Error moving video file: $fileName, it is likely a duplicate or same name"
        }
    } 
    elseif ($compressedExtensions -contains $fileExtension){
        Write-Host "Compressed File: $fileName"
        try {
            Move-Item -Path $file.FullName -Destination "~\Downloads\Compressed\$fileName" -ErrorAction Stop
        } catch {
            Write-Host "Error moving compressed file: $fileName, it is likely a duplicate or same name"
        }
    } else {
        Write-Host "Unknown File Type: $fileName"
        try {
            Move-Item -Path $file.FullName -Destination "~\Downloads\Other\$fileName"
        } catch {
            Write-Host "Error moving unknown file type: $fileName, it is likely a duplicate or same name"
        }
    }
}