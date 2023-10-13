<# 
  Prompts the user for some input
#>
function Read-Input {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Prompt,
    [switch]$Secret
  )

  $userInput = $null

  while ([string]::IsNullOrWhiteSpace($userInput)) {
    $userInput = Read-Host -Prompt "❓$Prompt" -AsSecureString:$Secret
    
    # Ugly hack that we need to do to retrieve the secure string for validation.
    # There's not simple way to check if the string is not null, empty or whitespace while it's a secure string.
    # Fortunatelly there's this ungly interope with .NET that allows us to retrieve the string from memory directly.
    if ($userInput.GetType() -eq [System.Security.SecureString]) {
      $userInput = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput))
    }

    if ([string]::IsNullOrWhiteSpace($userInput)) {
      Write-Host "You must enter a valid value." -ForegroundColor "Yellow"
    }   
  }  

  return $userInput
}

<#
Copies a template file to a destination folder while ensuring that 
any necessary recursive folders are created. It skips the copying process if the 
destination file already exists and is more recent than the template file, 
unless the '-Force' switch is used to force copying.
#>
function Copy-Template {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$From,

    [Parameter(Mandatory = $true)]
    [string]$To,

    [Parameter()]
    [switch]$Force
  )

  # Check if the template file exists
  if (-not (Test-Path -Path $From -PathType Leaf)) {
    Write-Error "Template file not found" -ForegroundColor "Gray"
    Write-Error "--> $From" -ForegroundColor "DarkGray"

    return
  }

  # Check if the destination folder exists; create it if it doesn't
  if (-not (Test-Path -Path $To -PathType Container)) {
    New-Item -Path $To -ItemType Directory -Force
  }

  # Determine the full destination file path
  $To = Join-Path -Path $To -ChildPath (Split-Path -Leaf $From)

  # Check if the destination file already exists and is more recent than the template file
  if (Test-Path -Path $To -PathType Leaf) {
    $templateLastWriteTime = (Get-Item $From).LastWriteTime
    $destinationLastWriteTime = (Get-Item $To).LastWriteTime

    if (!$Force -and $destinationLastWriteTime -ge $templateLastWriteTime) {
      Write-Host "The file already exists and is up to date" -ForegroundColor "Gray"
      Write-Host "--> $To" -ForegroundColor "DarkGray"

      return
    }
  }

  # Copy the template file to the destination
  Write-Host "🛠️ Copying template file" -ForegroundColor "DarkCyan"
  Write-Host "--> $From" -ForegroundColor "DarkGray"

  Copy-Item -Path $From -Destination $To -Force:$Force
}

<#
Checks whether the a given command exists or not. 
#>
function Test-Command {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Name
  )

  if (Get-Command $Name -ErrorAction SilentlyContinue) { return $true }
  else { return $false }
}

<#
Checks if we have an valid WSL distribution installed.
#>
function Test-WSL {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Distro
  )
    
  if ((wsl --list --quiet) -like $Distro) { return $true }
  else { return $false }     
}

<#
Creates a symlink (actually junctions) between two folders
#>
function New-Symlink {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Link,
    [Parameter(Mandatory = $true)]
    [string]$Target
  )

  # Get the junction if it exists (otherwise $null is returned)
  $junction = Get-Item -LiteralPath $Link -ErrorAction SilentlyContinue 

  if ($null -eq $junction) {
    Write-Host "🛠️ Creating symlink" -ForegroundColor "DarkCyan"
    Write-Host "--> $Target" -ForegroundColor "DarkGray"

    New-Item -ItemType Junction -Path $Link -Target $Target

    return
  }

  # If the junction exists but is not pointing to the right place
  if (-not ($junction.Target -eq (Resolve-Path -Path $Target))) {
    Write-Host "🛠️ Updating symlink target" -ForegroundColor "DarkCyan"
    Write-Host "--> $Target" -ForegroundColor "DarkGray"

    Remove-Item -LiteralPath $junction -Force
    New-Item -ItemType Junction -Path $Link -Target $Target

    return
  }

  Write-Host "Symlink already exists, skipping" -ForegroundColor "Gray"
  Write-Host "--> $Link" -ForegroundColor "DarkGray"
}

<#
Links folders that are usually on the user's home to OneDrive if they are being synched.
This is necessary because you can't simply cd into these folders from the user home directory.
#>
function Set-HomeSymlinksToOneDrive {
  $specialFolders = @(
    [Environment]::GetFolderPath('MyMusic'),
    [Environment]::GetFolderPath('MyVideos'),
    [Environment]::GetFolderPath('MyPictures'),
    [Environment]::GetFolderPath('MyDocuments')
  )

  foreach ($folderPath in $specialFolders) {
    $folderName = (Split-Path -Path $folderPath -Leaf)
    
    Write-Host "🛠️ Linking to OneDrive '$folderName'" -ForegroundColor "DarkCyan"

    $userHomeFolder = Resolve-Path -Path "$HOME\$folderName" -ErrorAction SilentlyContinue
    $oneDriveFolder = Resolve-Path -Path "$HOME\OneDrive\$folderName" -ErrorAction SilentlyContinue

    # If we can't find the corresponding folder on OneDrive, 
    # it means we probably don't have synch enabled, so we leave it alone
    if ($null -eq $oneDriveFolder) {
      Write-Host "No corresponding folder in OneDrive, skipping" -ForegroundColor "Gray"
      continue
    }

    # If we don't have a local folder in the home directory,
    # it means that we probably have synch enabled, so we try to symlink it
    if ($null -eq $userHomeFolder) {
      New-Symlink -Link "$HOME\$folderName" -Target $oneDriveFolder
      return
    }
    
    # If the home folder already exists but it's empty, we'll delete it and then create the symlink
    if ((Test-Path -Path $userHomeFolder) -and ((Get-ChildItem -Path $userHomeFolder).Count -eq 0)) {
      Write-Host "🛠️ Deleting empty '$folderName' folder" -ForegroundColor "DarkCyan" 
      New-Symlink -Link "$HOME\$folderName" -Target $oneDriveFolder
    }               
  }
}