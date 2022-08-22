
$Dotfiles = Join-Path -Path $HOME -ChildPath ".dotfiles"
$Documents = Split-Path(Split-Path $profile)
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#######################################################################
#                               Modules                               #
#######################################################################

# Custom modules path
$DotfilesModulePath = Join-Path -Path $Dotfiles -ChildPath "powershell\modules"
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#######################################################################
#                              Functions                              #
#######################################################################

Function Which {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][String] $Name
    )
    Process {
        Try {
            Get-Command $Name | Select-Object -ExpandProperty Definition
        }
        Catch {
            Write-Error -Message $_.Exception
            Break
        }
    }
}

Function LoadProfile {
    . $Profile
}

Function PrintMenu {
    Write-Host(" ----------------------- ")
    Write-Host("  PowerShell Functions   ")
    Write-Host(" ----------------------- ")
    Write-Host("")
    Write-Host("Command             Function")
    Write-Host("-------             --------")
    Write-Host("LoadProfile         Reload powershell profile from file")
    Write-Host("")
    Write-Host("")
}

#######################################################################
#                               Prompt                                #
#######################################################################

Function Global:Prompt() {
    "$(Split-Path -Leaf -Path (Get-Location)) $([char]::ConvertFromUtf32(8594)) ";
}
