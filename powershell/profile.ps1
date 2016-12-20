
Function LoadProfile {
    . $Profile
}

# Add Custom modules directory to the autoload path.
#$CustomModulePath = Join-path $ENV:HOME ".dotfiles/powershell/modules"

#if( -not $ENV:PSMODULEPATH.Contains($CustomModulePath) ){
    #$ENV:PSMODULEPATH = $ENV:PSMODULEPATH.Insert(0, "$CustomModulePath;")
#}
