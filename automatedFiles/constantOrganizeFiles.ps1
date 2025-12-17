Get-EventSubscriber | Where-Object {$_.SourceObject -is [System.IO.FileSystemWatcher]} | Unregister-Event
# Just getting rid of the old handlers in the script I've automated
# So I don't have to look at them in terminal when I run this one instead
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "$HOME/Downloads"
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action {
    Start-Sleep -Seconds 3
    $path = $Event.SourceEventArgs.FullPath
    $fileName = [System.IO.Path]::GetFileName($path)
    # Not sure about this style but it does get the file name

    if ($fileName -like "*.crdownload" -or 
        $fileName -like "*Unconfirmed*" -or 
        $fileName -like "*.tmp" -or 
        $fileName.StartsWith(".") -or
        $fileName -like "*.part") {
        return
    }
    # Not sure how effective this is with the sleeping line but it seems to work

    if (-not (Test-Path $path)) {
        return
    }
    # One last check to see if the file is still there after the sleep

    Write-Host "File $fileName has been created"
    & "$HOME/Documents/VSCode/powershell/powershellWork/automatedFiles/organizeFiles.ps1"
}

Write-Host "This code is watching the downloads folder. Cancel it to stop..."
while ($true) {
    Start-Sleep -Seconds 1
}
# This loop keeps the watcher running

# Automatically runs the organizeFiles script when a new file is downloaded