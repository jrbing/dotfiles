
<#
    .SYNOPSIS
        Powershell script to manage the installation and removal of Dotfiles from the system.

    .DESCRIPTION
        Powershell script to manage the installation and removal of Dotfiles from the system.

    .PARAMETER Install
        This parameter is used to install or update the installation of Dotfiles from the system.

    .PARAMETER Uninstall
        This parameter is used to uninstall the Dotfiles from the system.

    .PARAMETER Chocolatey
        This parameter is used to install chocolatey.

    .PARAMETER Help
        Display Help details.
#>

[CmdletBinding(DefaultParameterSetName="Help")]

Param(
    [Parameter (Mandatory=$true, ParameterSetName="Install")][Alias("i")][switch] $Install,
    [Parameter (Mandatory=$true, ParameterSetName="Uninstall")] [Alias("u")] [switch] $Uninstall,
    [Parameter (Mandatory=$true, ParameterSetName="Chocolatey")] [Alias("choc")] [switch] $Chocolatey,
    [Parameter (Mandatory=$false, ParameterSetName="Help")] [switch] $Help
)

Begin {

    Push-Location $PSScriptRoot

    $Dotfiles = Join-Path -Path $HOME -ChildPath ".dotfiles"
    $Documents = Split-Path(Split-Path $profile)
    $DotfilesModulePath = Join-Path -Path $PSScriptRoot -ChildPath "powershell\modules"

    ForEach ($module In (Get-ChildItem -Path $DotfilesModulePath -Filter *.psm1)) {
        Import-Module $module.FullName
    }

    Write-Information "Dotfiles: $Dotfiles"
    Write-Information "Documents: $Documents"
    Write-Information "Home: $HOME"

    $SymlinkMappings = @(
            @("$Dotfiles\powershell\profile.ps1", "$Documents\WindowsPowershell\profile.ps1"),
            @("$Dotfiles\git\gitconfig", "$HOME\.gitconfig"),
            @("$Dotfiles\vim\vimrc", "$HOME\_vimrc"),
            @("$Dotfiles\vim", "$HOME\vimfiles"),
            @("$Dotfiles\vscode\settings.json", "$env:APPDATA\Code\User\settings.json")
        )

    Function TestIsAdmin() {
        If (!(Test-IsAdmin)) {
            Throw "To continue run this script as an admin"
            Return
        }
    }

    Function NewSymlinkWithBackup([String]$Target, [String]$Path) {
        Write-Verbose "NewSymlinkWithBackup at $Path targeting $Target"

        If (Test-Symlink $path) {
            Remove-Symlink $path
        }

        If (!(Test-Path $target)) {
            Write-Verbose "Target doesn't exist. Skipping."
            Return
        }

        If (Test-Path $Path) {
            New-BackupItem $path -Delete
        }

        $pathDir = Split-Path -Parent $Path
        Write-Verbose $pathDir
        If (!(Test-Path $pathDir)) {
            mkdir -Force $pathDir | Out-Null
        }

        New-Symlink $Target $Path | Out-Null
    }

    Function RemoveSymlinkWithBackup([String]$Path) {
        If (Test-Symlink $Path) {
            Remove-Symlink $Path
        }

        Try { Restore-BackupItem $Path -Delete }

        Catch {
            Write-Error -Message $_.Exception
        }
    }
}

Process {
    If ($Install) {
        TestIsAdmin
        $SymlinkMappings | ForEach-Object { NewSymlinkWithBackup $_[0] $_[1] }
        Write-Output "Script Run Successfully. Please restart powershell for changes to take effect"
    } ElseIf ($Uninstall) {
        TestIsAdmin
        $symlinkMappings | ForEach-Object { RemoveSymlinkWithBackup $_[1] }
        Write-Output "Script Run Successfully. Please restart powershell for changes to take effect"

    } ElseIf ($Chocolatey) {
        Write-Verbose "Installing Chocolatey"
        Invoke-Expression ((New-Object net.webclient).DownloadString("https://chocolatey.org/install.ps1"))
    } Else {
        Get-Help $MyInvocation.MyCommand.Path
    }
}

End {
    Pop-Location
}
