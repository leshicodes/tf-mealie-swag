[CmdletBinding()]
param (
    [Parameter()]
    [TypeName]
    $ContainerConfigDirectoryPath = '/opt/containers' 
)
BEGIN {
    mkdir -p $ContainerConfigDirectoryPath
}
END {
    return get-path $ContainerConfigDirectoryPath
}