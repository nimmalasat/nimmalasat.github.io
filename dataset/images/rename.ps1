$folders = Get-ChildItem -Path "." -Directory

Write-Host "Found $($folders.Count) folders to process" -ForegroundColor Cyan
Write-Host ""

foreach ($folder in $folders) {
    Write-Host "Processing: $($folder.Name)" -ForegroundColor Green
    
    $allFiles = Get-ChildItem -Path $folder.FullName -File
    
    if ($allFiles.Count -eq 0) {
        Write-Host "  No files found" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "  Found $($allFiles.Count) files" -ForegroundColor Cyan
    
    $counter = 1
    foreach ($file in $allFiles | Sort-Object Name) {
        $oldName = $file.FullName
        $oldFileName = $file.Name
        $newName = Join-Path $folder.FullName "$counter.jpg"
        
        if (Test-Path $newName) {
            Remove-Item $newName -Force
        }
        
        Rename-Item -Path $oldName -NewName "$counter.jpg" -Force
        Write-Host "  OK: $oldFileName renamed to $counter.jpg" -ForegroundColor Cyan
        $counter++
    }
    
    Write-Host ""
}

Write-Host "All images renamed successfully!" -ForegroundColor Green