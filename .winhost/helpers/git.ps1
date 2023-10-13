. $PSScriptRoot\utils.ps1

<#
Configures Git options. 
#>
function Set-GitConfig {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string] $UserName,
    [Parameter(Mandatory = $true)]
    [string] $UserEmail,
    [Parameter(Mandatory = $false)]
    [string] $DefaultBranch = "master"
  )

  Write-Host "🛠️ Setting Git configurations" -ForegroundColor "DarkCyan"

  git config --global init.defaultBranch $DefaultBranch
  git config --global user.name $UserName
  git config --global user.email $UserEmail
}