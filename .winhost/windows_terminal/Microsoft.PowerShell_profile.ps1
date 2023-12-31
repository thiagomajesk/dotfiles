################################################################################
#                                Awesome PowerShell                            #
################################################################################

# Oh My Posh!
oh-my-posh init pwsh --config $PSScriptRoot/theme.omp.json | Invoke-Expression

# Import PowerShell plugins
Import-Module "Terminal-Icons"
Import-Module "PSReadLine"

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

################################################################################
#                                  PSReadLine                                  #
################################################################################
 
# Vi mode is available not 100% supported yet
# Set-PSReadLineOption -EditMode Vi

# Disable bell sound for wrong command
Set-PSReadlineOption -BellStyle "None"

# Use bat instead of cat if using PowerShell Core (it breaks on older versions)
if ($PSVersionTable.PSVersion -gt [Version] "7.0") { Set-Alias -Name "cat" -Value "bat" }
