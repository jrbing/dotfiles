
Function Invoke-Elevated {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][File] $FileName
    )
    Process {
        Try {
            $psi = New-Object System.Diagnostics.ProcessStartInfo $FileName
            $psi.Verb = "runas"
            $psi.WorkingDirectory = Get-Location
            [System.Diagnostics.Process]::Start($psi)
        }
        Catch {
            Write-Error -Message $_.Exception
            Break
        }
    }
}

Function Test-IsAdmin {
    Try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        Return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } Catch {
        Throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

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
