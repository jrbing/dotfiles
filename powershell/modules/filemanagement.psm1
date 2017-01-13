
<#
.SYNOPSIS
    Returns a resolved path for an string even if the path doesn't exist
.PARAMETER Path
    The Path to resolve
#>
Function Resolve-NonExistentPath {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [String]
        $Path
    )

    $Path = $ExecutionContext.InvokeCommand.ExpandString($Path)
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
}

<#
.SYNOPSIS
    Creates a symbolic link between a path (which will be created) and the target
    Requires Admin Access
.PARAMETER Target
    The path to the where the symPath will point to
.PARAMETER Path
    The path to where the symPath will be created
#>
Function New-Symlink {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
        [String]
        $Target,

        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=1)]
        [String]
        $Path
    )

    BEGIN { }

    PROCESS {
        $Path = (Resolve-NonExistentPath $Path)

        #Ensure the Target exists
        if (-not(Test-Path $Target)) {
            throw "The specified target doesn't exist: $Target"
        }

        #Ensure the Path doesn't already exist
        if (Test-Path $Path) {
            throw "A file already exists at the requested Path point. $Path"
        }

        $isTargetDirectory = Test-Path $Target -PathType Container

        Write-Verbose "Attempting to Add Symlink for $Path and target $Target"

        #If the target is a directory we actually create a junction
        if ($isTargetDirectory) {
            $output = cmd /c mklink /D `"$Path`" `"$Target`"
        }
        else {
            $output = cmd /c mklink `"$Path`" `"$Target`"
        }

        Write-Output $Path
    }

    END { }
}

<#
.SYNOPSIS
    Returns if a specified path is a symlink or not
.PARAMETER Path
    The path to where the symlink to be tested
#>
Function Test-Symlink
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [String]
        $Path
    )

    BEGIN {}

    PROCESS {
        $Path = (Resolve-NonExistentPath $Path)

        if (-not(Test-Path $path)) {return $false}
        $file = Get-Item $path -Force -ea 0
        return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
    }

    END {}
}

<#
.SYNOPSIS
    Deletes a symlink
.PARAMETER Path
    The path of the symlink to be deleted
#>
Function Remove-Symlink {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [String]
        $Path
    )

    BEGIN {}

    PROCESS {
        $Path = (Resolve-NonExistentPath $Path)

        Write-Debug "Attempting to Remove Symlink for $Path"

        #Ensure the Target exists
        if (-not(Test-Symlink $Path)) {
            throw "The specified path is not a symlink"
        }

        $File = Get-Item $Path

        #Use .net plugin in the event that the dir a symlink is pointing to gets deleted.
        if (($File).PSIsContainer) {
            [System.IO.Directory]::Delete($File.FullName,$true)
        } else {
            [System.IO.File]::Delete($File.FullName)
        }
    }

    END {}
}

<#
.SYNOPSIS
    Backups an item
.PARAMETER Path
    The path of the item to backup
.PARAMETER BackupPath
    The path to back the item up to
#>
Function New-BackupItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [String]
        $Path,

        [Parameter(Mandatory=$false, Position=1)]
        [String]
        $BackupPath,

        [Parameter(Mandatory=$false)]
        [Switch]
        $Delete
    )

    BEGIN {}

    PROCESS {

        $Path = (Resolve-NonExistentPath $Path)
        if (!$BackupPath) { $BackupPath = Resolve-NonExistentPath "$Path.bak" }
        Write-Verbose "Backup Path: $BackupPath"

        if (!(Test-Path $Path)) {
            throw "Path does not exist."
        }

        if (Test-Path $BackupPath) {
            throw "Backup Path Already Exists"
        }

        if (Test-Symlink $Path) {
            throw "Path is a symlink. Can't back it up"
        }

        if ($Delete) {
            Move-Item $Path $BackupPath
        } else {
            Copy-Item $Path $BackupPath -Recurse
        }
    }

    END {}
}

<#
.SYNOPSIS
    Backups an item
.PARAMETER Path
    The path of the item to be restored.
.PARAMETER BackupPath
    The path to restore the item from.
.PARAMETER Delete
    Option to delete the backup item
#>
Function Restore-BackupItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [String]
        $Path,

        [Parameter(Mandatory=$false, Position=1)]
        [String]
        $BackupPath,

        [Parameter(Mandatory=$false)]
        [Switch]
        $Delete
    )

    BEGIN {}

    PROCESS {
        $Path = (Resolve-NonExistentPath $Path)
        if (!$BackupPath) { $BackupPath = Resolve-NonExistentPath "$Path.bak" }

        Write-Verbose "Restoring backup from $BackupPath to $Path"

        New-BackupItem $BackupPath $Path -Delete:$Delete
    }

    END {}
}

Function New-File {
    [CmdletBinding()]
    Param (
        [Parameter (Mandatory=$false, ValueFromPipeline=$true)]
        [string] $Path
    )

    New-Item $Path -Type File
}
