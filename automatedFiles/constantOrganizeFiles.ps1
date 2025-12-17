Get-EventSubscriber | Where-Object {$_.SourceObject -is [System.IO.FileSystemWatcher]} | Unregister-Event

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "$HOME/Downloads"
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action {
    Start-Sleep -Seconds 3
    $path = $Event.SourceEventArgs.FullPath
    $fileName = [System.IO.Path]::GetFileName($path)

    if ($fileName -like "*.crdownload" -or 
        $fileName -like "*Unconfirmed*" -or 
        $fileName -like "*.tmp" -or 
        $fileName.StartsWith(".") -or
        $fileName -like "*.part") {
        return
    }

    if (-not (Test-Path $path)) {
        return
    }

    Write-Host "File $fileName has been created"
    & "$HOME/Documents/VSCode/powershell/powershellWork/automatedFiles/organizeFiles.ps1"
}

Write-Host "This code is watching the downloads folder. Cancel it to stop..."
while ($true) {
    Start-Sleep -Seconds 1
}