
Import-Module PSColor
Import-Module Pscx -arg @{
    TextEditor = 'code.exe'
    ModulesToImport = @{
        CD                = $true
        DirectoryServices = $false
        FileSystem        = $true
        GetHelp           = $false
        Net               = $true
        Prompt            = $false
        TranscribeSession = $false
        Utility           = $true
        Vhd               = $false
        Wmi               = $false
    }
}

Function LoadProfile {
    . $Profile
}


Function Global:Prompt {
    #PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1))
    $RealCommandStatus = $?
    $RealLASTEXITCODE = $LASTEXITCODE
    $Lambda = [char]::ConvertFromUtf32(955)
    $ForwardArrow = [char]::ConvertFromUtf32(8594)

    If ( $RealCommandStatus -eq $True ) {
        $EXIT="Green"
    } Else {
        $EXIT="Red"
    }

    $CurrentDirectory = Split-Path -Leaf -Path (Get-Location)

    Write-Host
    Write-Host "$Lambda " -ForegroundColor Gray -NoNewline
    Write-Host "$CurrentDirectory" -NoNewLine -ForegroundColor DarkGray

    Write-Host " $ForwardArrow" -NoNewLine -ForegroundColor $EXIT
    $Global:LASTEXITCODE = $RealLASTEXITCODE
    Return " "
}

$Global:PSColor = @{
    File = @{
        Default    = @{ Color = 'White' }
        Directory  = @{ Color = 'Green'}
        Reparse    = @{ Color = 'Magenta'}
        Hidden     = @{ Color = 'DarkGray'; Pattern = '^\.' }
        Code       = @{ Color = 'Magenta'; Pattern = '\.(java|c|cpp|cs|js|css|html|Dockerfile|gradle|pp|packergitignore|gitattributes|go|)$' }
        Executable = @{ Color = 'Green'; Pattern = '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg|sh|fsx|)$' }
        Text       = @{ Color = 'Cyan'; Pattern = '\.(txt|cfg|conf|ini|csv|log|config|xml|yml|md|markdown|properties|json|todo)$' }
        Compressed = @{ Color = 'Yellow'; Pattern = '\.(zip|tar|gz|rar|jar|war)$' }
    }
    Service = @{
        Default = @{ Color = 'White' }
        Running = @{ Color = 'DarkGreen' }
        Stopped = @{ Color = 'DarkRed' }
    }
    Match = @{
        Default    = @{ Color = 'White' }
        Path       = @{ Color = 'Green'}
        LineNumber = @{ Color = 'Yellow' }
        Line       = @{ Color = 'White' }
    }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
If (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

