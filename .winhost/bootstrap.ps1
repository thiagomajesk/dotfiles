#############################################################################
#                               PRELUDE                                    #
#############################################################################

# Check we have everything needed for running the script
. $PSScriptRoot\helpers\utils.ps1
. $PSScriptRoot\helpers\scoop.ps1
. $PSScriptRoot\helpers\git.ps1

# Allow execution policy for current user
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Do we have WSL already installed? If not, abort the script as it's required.
if (-not (Test-WSL -Distro "Ubuntu")) { 
  Write-Host "⚠️ It seems you might not have WSL installed, exiting" -ForegroundColor "Orange"
  exit 5
}

#############################################################################
#                      ENVIRONMENT VARIABLES                                #
#############################################################################

# Configure base repository URL (this will be used for cloning stuff into WSL later)
$dotfilesGitHubRepository = "https://github.com/thiagomajesk/dotfiles" 

# Request any inputs we may need from the user
# We are going to use GitHub's private e-mail from now on
# $gitUserName = Read-Input -Prompt "What Git user name should be used?"
# $gitUserEmail = Read-Input -Prompt "What Git user email should be used?"

# Gets the "MyDocuments" path for the current user since it can be local or remote
$UserMyDocumentsPath = [Environment]::GetFolderPath('MyDocuments')

$PowerShellProfileDirectory = "$UserMyDocumentsPath\PowerShell"
$PowerShellLegacySymlink = "$UserMyDocumentsPath\WindowsPowerShell"
$WindowsTerminalSettingsDirectory = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

$PowerShellProfileTemplate = "$PSScriptRoot\windows_terminal\Microsoft.PowerShell_profile.ps1"
$PowerShellThemeTemplate = "$PSScriptRoot\windows_terminal\theme.omp.json"
$WindowsTerminalSettingsTemplate = "$PSScriptRoot\windows_terminal\settings.json"

$GitConfigTemplate = "$PSScriptRoot\git\.gitconfig"

#############################################################################
#                          SCOOP PACKAGES                                   #
#############################################################################

Install-Scoop
Import-ScoopPackages -Path "$PSScriptRoot\scoop\scoopfile.json"
Set-ScoopContext -Package "vscode"
Set-ScoopContext -Package "notepadplusplus"

#############################################################################
#                          WINDOWS TERMINAL                                 #
#############################################################################

Write-Host "⚙️ Configuring Windows Terminal" -ForegroundColor "Blue"  

# Copy the templates for the PowerShell profile configuration
Copy-Template -From $PowerShellProfileTemplate -To $PowerShellProfileDirectory
Copy-Template -From $PowerShellThemeTemplate -To $PowerShellProfileDirectory

# Configures templates for the Windows Terminal settings
Copy-Template -From $WindowsTerminalSettingsTemplate -To $WindowsTerminalSettingsDirectory

# Create the profile folder for PowerShell Core and a symlink the old PowerShell 
# folder so we can use the same profile for both versions of PowerShell
New-Item -Path $PowerShellProfileDirectory -ItemType Directory -Force | Out-Null
New-Symlink -Link $PowerShellLegacySymlink -Target $PowerShellProfileDirectory

#############################################################################
#                                 GIT                                       #
#############################################################################

Write-Host "⚙️ Configuring Git" -ForegroundColor "Blue"

Copy-Template -From $GitConfigTemplate -To $HOME
# It seems GitHub has a setting for making e-mails private, so we'll be using that.
# Read more how to enable that here: https://giuseppegurgone.com/privacy-hide-e-mail-github. 
# If you can't push using the private e-mail, make sure that you `git commit --amend --reset-author` your commit.
# Set-GitConfig -UserName $gitUserName -UserEmail $gitUserEmail

#############################################################################
#                                 WSL                                       #
#############################################################################

Write-Host "⚙️ Configuring WSL" -ForegroundColor "Blue"  

# Make sure everything is nicely updated so we can grab our packages 
wsl sudo apt -y update
wsl sudo apt -y upgrade

# Install packages needed for other tools (like Homebrew) 
wsl sudo apt install -y build-essential procps curl file git yadm
# -----------------------------------------------------------^^^^
# We are also installing YADM so we have a way to restore *NIX dotfiles

# Pull the dotfiles for the WSL system
wsl yadm clone $dotfilesGitHubRepository --bootstrap

#############################################################################
#                          OPERATING SYSTEM                                 #
#############################################################################

Write-Host "⚙️ Configuring Operating System" -ForegroundColor "Blue"  

# Create symlinks for folders synched to OneDrive. This will try to sync 
# "MyMusic", "MyVideos", "MyPictures" and "MyDocuments" to OneDrive and it's
# helpful to allow you to navigate from the user directory directly to OneDrive folders
Set-HomeSymlinksToOneDrive
