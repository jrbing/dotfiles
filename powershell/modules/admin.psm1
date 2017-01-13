
# TODO: add help
Function Invoke-Elevated {
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    [System.Diagnostics.Process]::Start($psi);
}

# TODO: add help
function Test-IsAdmin {
    Try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        Return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } Catch {
        Throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}
