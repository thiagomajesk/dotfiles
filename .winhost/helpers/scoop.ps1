. $PSScriptRoot\utils.ps1

$script:ScoopDirectory = "$HOME\scoop\apps"

<#
Installs the scoop CLI if it's not installed. 
#>
function Install-Scoop {
  Write-Host "🛠️ Installing Scoop" -ForegroundColor "DarkCyan"

  if (-not (Test-Command -Name "scoop")) {
    Invoke-Expression -Command "irm get.scoop.sh | iex"
  }
  else {
    Write-Host "Scoop already installed, skipping" -ForegroundColor "Gray"
  }
}

<#
Imports/Installs the packages from a scoopfile. 
#>
function Import-ScoopPackages {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Path
  )

  Write-Host "🛠️ Importing Scoop packages" -ForegroundColor "DarkCyan"

  if (Test-Path -Path $Path -PathType Leaf) {
    Invoke-Expression -Command "scoop import $Path"
  }
  else {
    Write-Host "Invalid scoopfile path provided" -ForegroundColor "Red"
    Write-Host "--> $Path" -ForegroundColor "DarkGray"
  }
}

<#
Installs context for the given scoop package. 
#>
function Set-ScoopContext {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $Package
  )

  $contextFile = "$ScoopDirectory\$Package\current\install-context.reg"
  Write-Host "🛠️ Installing context for package '$Package'" -ForegroundColor "DarkCyan"
  
  if (Test-Path -Path $contextFile -PathType Leaf) {
    Invoke-Expression -Command "reg import $contextFile"
  }
  else {
    Write-Host "No context registry to install" -ForegroundColor "Red"
  }

  Write-Host "--> $contextFile" -ForegroundColor "DarkGray"
}