function Get-CurrenProxyStatus {
    $RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    $npmProxyStatus = npm config get proxy
    $gitProxyStatus = git config --global --get http.proxy
    $globalProxyStatus = (Get-ItemProperty -Path $RegistryPath -Name ProxyEnable).ProxyEnable
    $proxyServerAddress = (Get-ItemProperty -Path $RegistryPath -Name ProxyServer).ProxyServer
    $proxyEnvironmentVariable = [Environment]::GetEnvironmentVariable("HTTP_PROXY", "User")

    # Set individual proxy status variables
    $GlobalProxyStatus = if ($globalProxyStatus -eq 1) { "`e[38;2;0;255;0mEnabled`e[0m" } else { "`e[38;2;255;0;0mDisabled`e[0m" }
    $ProxyServerAddress = "$proxyServerAddress"
    $NpmProxyStatus = if ($npmProxyStatus -eq "null") { "`e[38;2;255;0;0mDisabled`e[0m" } else { "`e[38;2;0;255;0mEnabled`e[0m" }
    $GitProxyStatus = if ($null -eq $gitProxyStatus -or $gitProxyStatus -eq "") { "`e[38;2;255;0;0mDisabled`e[0m" } else { "`e[38;2;0;255;0mEnabled`e[0m" }
    $ProxyEnvironmentVariable = if ($null -eq $proxyEnvironmentVariable -or $proxyEnvironmentVariable -eq "") { "`e[38;2;255;0;0mNot Set`e[0m" } else { "$proxyEnvironmentVariable" }

    # Create hashtable with proxy status
    $currentProxyStatus = [ordered]@{
        "ProxyServerAddress"       = "Proxy Server  : $ProxyServerAddress"
        "Global"                   = "Global        : $GlobalProxyStatus"
        "NPM"                      = "NPM           : $NpmProxyStatus"
        "Git"                      = "Git           : $GitProxyStatus"
        "ProxyEnvironmentVariable" = "Proxy Env-Var : $ProxyEnvironmentVariable"
    }

    return $currentProxyStatus
}