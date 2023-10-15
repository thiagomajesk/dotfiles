$repo = "https://github.com/thiagomajesk/dotfiles"

$downloadUrl = "$repo/archive/master.zip"

# Create a temporary directory
$folderName = "_dotfiles"
$zipFileName = "dotfiles.zip"
$downloadDir = New-Item -ItemType Directory -Force -Path (Join-Path $env:TEMP $folderName)

# Download the ZIP file from GitHub
Write-Host "Downloading repo archive from $repo" -ForegroundColor "Magenta"
Invoke-WebRequest -Uri $downloadUrl -OutFile (Join-Path $downloadDir $zipFileName)

# Unzip the downloaded ZIP file to the extraction path
Write-Host "Extracting downloaded archive to $downloadDir" -ForegroundColor "Magenta"
Expand-Archive -Path (Join-Path $downloadDir $zipFileName) -DestinationPath $downloadDir -Force

$bootstrapFile = Join-Path $downloadDir "dotfiles-master\.winhost\bootstrap.ps1"

# Run the boostrap file
Write-Host "Running the bootstrap file" -ForegroundColor "Magenta"
Start-Process -FilePath "powershell.exe" -ArgumentList "-File $bootstrapFile"