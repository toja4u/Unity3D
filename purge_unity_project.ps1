# ***************************************************************** #
# Purge Unity3D project directory                                   #
#                                                                   #
# Author: toja                                                      #
# Quelle: https://github.com/toja4u/Unity3D/                        #
# ***************************************************************** #

$IgnorePath = Get-Location
$CurrPath = Get-Location

function MyRemove {
    param($path)
    If (-Not "$path" -eq "") {
        If ($path -match "\*" -or $path -match "\[") {
            # Path with wildcard or alternative (upper or lower case) notation
            Remove-Item -Path "$CurrPath\$path" -Recurse
        } Else {
            # Path with exacte spelling
            If ([System.IO.Directory]::Exists("$CurrPath\$path") -or [System.IO.File]::Exists("$CurrPath\$path")) {
                Remove-Item -Path "$CurrPath\$path" -Recurse
            }
        }
    }
}

ForEach ($line in Get-Content -Path $IgnorePath\Unity.gitignore) {
    # Comment lines are ignored
    If ($line -notmatch "(\s?)+#") {
        MyRemove $line
    }
}
