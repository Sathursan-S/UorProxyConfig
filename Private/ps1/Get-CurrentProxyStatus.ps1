function Get-CurrenProxyStatus {
    $RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    $npmProxyStatus = npm config get proxy
    $gitProxyStatus = git config --global --get http.proxy
    $globalProxyStatus = (Get-ItemProperty -Path $RegistryPath -Name ProxyEnable).ProxyEnable
    $proxyServerAddress = (Get-ItemProperty -Path $RegistryPath -Name ProxyServer).ProxyServer
    $proxyEnvironmentVariable = [Environment]::GetEnvironmentVariable("HTTP_PROXY", "User")

    # Set individual proxy status variables
    $GlobalProxyStatus = if ($globalProxyStatus -eq 1) { "Enabled" } else { "Disabled" }
    $ProxyServerAddress = "$proxyServerAddress"
    $NpmProxyStatus = if ($npmProxyStatus -eq "null") { "Disabled" } else { "Enabled" }
    $GitProxyStatus = if ($null -eq $gitProxyStatus -or $gitProxyStatus -eq "") { "Disabled" } else { "Enabled" }
    $ProxyEnvironmentVariable = if ($null -eq $proxyEnvironmentVariable -or $proxyEnvironmentVariable -eq "") { "Not Set" } else { "$proxyEnvironmentVariable" }

    # Determine if ANSI escape sequences should be used based on PowerShell version
    if ($PSVersionTable.PSVersion.Major -ge 7) {
        $EnableColor = $true
    } else {
        $EnableColor = $false
    }

    # Define ANSI escape sequences for color formatting
    $GreenEscapeSequence = "`e[38;2;0;255;0m"
    $RedEscapeSequence = "`e[38;2;255;0;0m"
    $ResetEscapeSequence = "`e[0m"

    $ColoredProxyStatus = @{
        "ProxyServerAddress"       = "$ProxyServerAddress"
        "Global"                   = "$($GlobalProxyStatus)"
        "NPM"                      = "$($NpmProxyStatus)"
        "Git"                      = "$($GitProxyStatus)"
        "ProxyEnvironmentVariable" = "$($ProxyEnvironmentVariable)"
    }

     # Apply color formatting based on proxy status
    if ($EnableColor) {
        if ($GlobalProxyStatus -eq 'Enabled') {
            $ColoredProxyStatus["Global"] = ("$GreenEscapeSequence" + $ColoredProxyStatus["Global"] + "$ResetEscapeSequence" )
        } elseif ($GlobalProxyStatus -eq 'Disabled') {
            $ColoredProxyStatus["Global"] = "$RedEscapeSequence" + $ColoredProxyStatus["Global"] + "$ResetEscapeSequence"
        }

        if ($NpmProxyStatus -eq 'Enabled') {
            $ColoredProxyStatus["NPM"] = "$GreenEscapeSequence" + $ColoredProxyStatus["NPM"] + "$ResetEscapeSequence"
        } elseif ($NpmProxyStatus -eq 'Disabled') {
            $ColoredProxyStatus["NPM"] = "$RedEscapeSequence" + $ColoredProxyStatus["NPM"] + "$ResetEscapeSequence"
        }

        if ($GitProxyStatus -eq 'Enabled') {
            $ColoredProxyStatus["Git"] = "$GreenEscapeSequence" + $ColoredProxyStatus["Git"] + "$ResetEscapeSequence"
        } elseif ($GitProxyStatus -eq 'Disabled') {
            $ColoredProxyStatus["Git"] = "$RedEscapeSequence" + $ColoredProxyStatus["Git"] + "$ResetEscapeSequence"
        }

        if ($ProxyEnvironmentVariable -ne 'Not Set') {
            $ColoredProxyStatus["ProxyEnvironmentVariable"] = "$GreenEscapeSequence" + $ColoredProxyStatus["ProxyEnvironmentVariable"] + "$ResetEscapeSequence"
        } else {
            $ColoredProxyStatus["ProxyEnvironmentVariable"] = "$RedEscapeSequence" + $ColoredProxyStatus["ProxyEnvironmentVariable"] + "$ResetEscapeSequence"
        }

    # Create hashtable with proxy status
    $currentProxyStatus = [ordered]@{
        "ProxyServerAddress"       = "Proxy Server  : $ProxyServerAddress"
        "Global"                   = "Global        : $($ColoredProxyStatus["Global"])"
        "NPM"                      = "NPM           : $($ColoredProxyStatus["NPM"])"
        "Git"                      = "Git           : $($ColoredProxyStatus["Git"])"
        "ProxyEnvironmentVariable" = "Proxy Env-Var : $($ColoredProxyStatus["ProxyEnvironmentVariable"])"
    }
} else{
    $currentProxyStatus = [ordered]@{
        "ProxyServerAddress"       = "Proxy Server  : $ProxyServerAddress"
        "Global"                   = "Global        : $GlobalProxyStatus"
        "NPM"                      = "NPM           : $NpmProxyStatus"
        "Git"                      = "Git           : $GitProxyStatus"
        "ProxyEnvironmentVariable" = "Proxy Env-Var : $ProxyEnvironmentVariable"
    }
}
    return $currentProxyStatus
}