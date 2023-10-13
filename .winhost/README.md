# Windows Host Setup

This serves as a guide to setup a development environment using Windows 11 and Windows Subsystem For Linux (WSL).

## How it works

The script is fairly simple and you can follow even with a superficial understanding of PowerShell. This is what it does currently:

- Installs Scoop with:
    - Git
    - Powertoys
    - Tableplus
    - VSCode
    - Powershell Core
    - ... And a series of apps I use daily
- Installs and configures Oh My Posh for PowerShell
- Installs and configures Zoxide for Powershell
- Installs and configures Terminal Icons for Powershell
- Installs and configures PSReadline for Powershell
- Installs and configures FZF for Powershell
- Installs and configures Bat for Powershell
- Configures Windows Terminal

> ⚠️ **A word of caution before you use this script:** Since Windows is not exactly a developer-friendly operating system, setting up replicable environments might be a convoluted PITA. Because of the hassle, this configuration is a much simpler version of other scripts that I've found on the internet. In particular, it was heavily inspired by [this other repository](https://github.com/JMOrbegoso/Dotfiles-for-Windows-11). If you want better structure to setup your dotfiles, I recommend you ~~don't use Windows~~ take a look at the [PSWindowsDotFiles](https://github.com/JMOrbegoso/PSWindowsDotfiles) tool.

## Usage

### Debloating (optional)

After a clean Windows instalation, run the following command as admin to launch the debloating tool: 

```powershell
irm https://christitus.com/win | iex
```

> 👏 A huge thanks to Chris Titus for coming up with this solution: https://github.com/ChrisTitusTech/winutil.

After running the command we'll want to check and apply some settings on the tweaks tab. Here are my recommended settings:

- Run OO Shutup
- Disable Telemetry
- Disable Wifi-Sense
- Disable Activity History
- Delete Temporary Files
- Run Disk Cleanup
- Disable Location Tracking
- Disable Hibernation
- Set Services to Manual

### Step 1: WSL

If you haven't yet, install Ubuntu in WSL using the following command:

```powershell
wsl --install -d Ubuntu
```

After the distribution is installed, WSL will prompt you for a user and password (for simplicity sake, you can use the same user name and PIN that you use to log in on your Windows host).

> ⚠️ **Attention**: WSL comes pre-installed on Windows 11, if that's not your case, first install it using the command above and restart your computer before continuing to the next steps. If in doubt, head over to the official documentation on: https://learn.microsoft.com/windows/wsl to get the necessary information to get WSL up and running for your system.

### Step 2: Bootstrapping

Now we are going to install all the software we need. Open a PowerShell terminal and run the bootstrap script (no need to run as admin):

```powershell
./bootstrap.ps1
```

> ⚠️ **Attention**: Depending on your Windows version, you might have OneDrive pre-configured to sync some of your files. This means that the path to those folders that are usually inside the home directoy won't be there. One of the things the bootstrap script will try do to is symlinking those OneDrive folders back to your home directory. You can manually remove this step from the script if you don't need it.