
$Dotfiles = Join-Path -Path $HOME -ChildPath ".dotfiles"
$Documents = Split-Path(Split-Path $profile)

#######################################################################
#                               Modules                               #
#######################################################################

# Custom modules path
$DotfilesModulePath = Join-Path -Path $Dotfiles -ChildPath "powershell\modules"

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
