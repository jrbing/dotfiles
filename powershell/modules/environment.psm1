<#
    .SYNOPSIS
        Sets an environment variable.

    .PARAMETER Variable
        The varible to set.

    .PARAMETER Value
        The value to give the variable.

    .PARAMETER Process
        Set the variable on the process level.

    .PARAMETER User
        Set the variable on the user level.

    .PARAMETER Machine
        Set the variable on the machine level.
#>
Function Set-EnvironmentVariable {
    [CmdletBinding()]
    Param (
        [Parameter (Mandatory=$true, Position=0)][String] $Variable,
        [Parameter (Mandatory=$true, Position=1)][String] $Value,
        [Parameter (Mandatory=$true, ParameterSetName="process")][Switch] $Process,
        [Parameter (Mandatory=$true, ParameterSetName="user")][Switch] $User,
        [Parameter (Mandatory=$true, ParameterSetName="machine")][Switch] $Machine

    Begin {}

    Process {
        If ($Process) { $envT = [System.EnvironmentVariableTarget]::Process }
        ElseIf ($User) { $envT = [System.EnvironmentVariableTarget]::User }
        ElseIf ($Machine) { $envT = [System.EnvironmentVariableTarget]::Machine }

        Write-Verbose "SET $Variable=$Value for $envT"
        [Environment]::SetEnvironmentVariable($Variable, $Value, $envT)
    }

    End {}
}

<#
    .SYNOPSIS
        Gets an environment variable.

    .PARAMETER Variable
        The varible to get.

    .PARAMETER Process
        Gets the variable on the process level.

    .PARAMETER User
        Gets the variable on the user level.

    .PARAMETER Machine
        Gets the variable on the machine level.
#>
Function Get-EnvironmentVariable {
    [CmdletBinding()]
    Param (
        [Parameter (Mandatory=$true, ValueFromPipeline=$true, Position=0)][String] $Variable,
        [Parameter (Mandatory=$true, ParameterSetName="process")][Switch] $Process,
        [Parameter (Mandatory=$true, ParameterSetName="user")][Switch] $User,
        [Parameter (Mandatory=$true, ParameterSetName="machine")][Switch] $Machine
    )

    Begin {}

    Process {
        If ($Process) { $envT = [System.EnvironmentVariableTarget]::Process }
        ElseIf ($User) { $envT = [System.EnvironmentVariableTarget]::User }
        ElseIf ($Machine) { $envT = [System.EnvironmentVariableTarget]::Machine }

        $EnvVar = [Environment]::GetEnvironmentVariable($Variable, $envT)
        Write-Output $EnvVar
    }

    End {}
}

<#
    .SYNOPSIS
        Removes an environment variable.

    .PARAMETER Variable
        The varible to remove.

    .PARAMETER Process
        Removes the variable on the process level.

    .PARAMETER User
        Removes the variable on the user level.

    .PARAMETER Machine
        Removes the variable on the machine level.
#>
Function Remove-EnvironmentVariable {
    [CmdletBinding()]
    Param (
        [Parameter (Mandatory=$true, ValueFromPipeline=$true, Position=0)][String] $Variable,
        [Parameter (Mandatory=$true, ParameterSetName="process")][Switch] $Process,
        [Parameter (Mandatory=$true, ParameterSetName="user")][Switch] $User,
        [Parameter (Mandatory=$true, ParameterSetName="machine")][Switch] $Machine
    )

    Begin {}

    Process {
        If ($Process) { $envT = [System.EnvironmentVariableTarget]::Process }
        ElseIf ($User) { $envT = [System.EnvironmentVariableTarget]::User }
        ElseIf ($Machine) { $envT = [System.EnvironmentVariableTarget]::Machine }
        Write-Verbose "UNSET $Variable for $envT"
        [Environment]::SetEnvironmentVariable($Variable, $null, $envT)
    }

    End {}
}

<#
    .SYNOPSIS
        Adds a variable at the end of an environment variable.

    .DESCRIPTION
        Adds a variable at the end of an environmental variable.
        This is useful for adding an extra value onto the Path
        variable or other variables which are combined lists of
        variables.

    .PARAMETER Variable
        The name of the environment variable to add the new value
        onto.

    .PARAMETER Value
        The value to add the new variable onto the Environment Variable

    .PARAMETER Process
        Set the variable on the process level.

    .PARAMETER User
        Set the variable on the user level.

    .PARAMETER Machine
        Set the variable on the machine level.

    .PARAMETER Seperator
        The seperator to use between the exisiting values and the new values.
#>
Function Add-VariableToEnvironmentVariable {
    [CmdletBinding()]
    Param(
        [Parameter (Mandatory=$true, Position=0)][String] $Variable,
        [Parameter (Mandatory=$true, Position=1)][String] $Value,
        [Parameter (Mandatory=$true, ParameterSetName="process")][Switch] $Process,
        [Parameter (Mandatory=$true, ParameterSetName="user")][Switch] $User,
        [Parameter (Mandatory=$true, ParameterSetName="machine")][Switch] $Machine,
        [Parameter (Mandatory=$false, Position=2)][String] $Seperator

    Begin {}

    Process {
        If (!$Seperator) { $Seperator = ";" }

        $PSBoundParameters.Remove("Value") | Out-Null
        $PSBoundParameters.Remove("Seperator") | Out-Null
        $existingValue = Get-EnvironmentVariable @PSBoundParameters

        If ($existingValue -and (($existingValue.Split($Seperator) | Select-String -simplematch $Value).Count -gt 0)) {
            Write-Verbose "Variable already exists in environment variable"
            Return
        }

        If ($existingValue -and $existingValue -ne "") {
            $Value = "$existingValue$Seperator$Value"
        }

        $PSBoundParameters.Add("Value", $Value) | Out-Null
        Set-EnvironmentVariable @PSBoundParameters
    }

    End {}
}

<#
    .SYNOPSIS
        Removes a variable from a list of variables in an environment variable.

    .DESCRIPTION
        Removes a variable from a list of variables in an environment variable.
        This is useful for removing values from the Path
        variable or other variables which are combined lists of
        variables.

    .PARAMETER Variable
        The name of the environment variable to remove the value
        from.

    .PARAMETER Value
        The value to remove from the Environment Variable

    .PARAMETER Process
        Remove the variable on the process level.

    .PARAMETER User
        Remove the variable on the user level.

    .PARAMETER Machine
        Remove the variable on the machine level.

    .PARAMETER Seperator
        The seperator to used in the environment variable between the variables.
#>
Function Remove-VariableFromEnvironmentVariable {
    [CmdletBinding()]
    Param(
        [Parameter (Mandatory=$true, Position=0)][String] $Variable,
        [Parameter (Mandatory=$true, Position=1)][String] $Value,
        [Parameter (Mandatory=$true, ParameterSetName="process")][Switch] $Process,
        [Parameter (Mandatory=$true, ParameterSetName="user")][Switch] $User,
        [Parameter (Mandatory=$true, ParameterSetName="machine")][Switch] $Machine,
        [Parameter (Mandatory=$false, Position=2)][String] $Seperator

    Begin {}

    Process {
        If (!$Seperator) { $Seperator = ";" }

        $PSBoundParameters.Remove("Value") | Out-Null
        $PSBoundParameters.Remove("Seperator") | Out-Null
        $existingValue = Get-EnvironmentVariable @PSBoundParameters

        If (!$existingValue -or $existingValue -eq "" -or (($existingValue.Split($Seperator) | Select-String -simplematch $Value).Count -eq 0)) {
            Write-Verbose "Value does not exist in the environment variable."
            Return
        }

        $filteredVariables = $existingValue.Split($Seperator) | Where-Object { $_ -and $_ -ne "" -and $_ -ne $Value }
        $Value = $filteredVariables -join $Seperator

        If ($Value -eq "") {
            Remove-EnvironmentVariable @PSBoundParameters
            Return
        }

        $PSBoundParameters.Add("Value", $Value) | Out-Null
        Set-EnvironmentVariable @PSBoundParameters
    }

    End {}
}
