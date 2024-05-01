function Switch-Git-Proxy {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProxySocketAddress
    )
    
    begin {
        $gitProxyStatus = git config --global --get http.proxy
        Write-Host "Current Git proxy settings: $gitProxyStatus"
    }

    process {
        try {
            if ($null -eq $gitProxyStatus -or $gitProxyStatus -eq "") {
                Write-Host "Enabling Git proxy settings..." -ForegroundColor Green
                git config --global http.proxy $ProxySocketAddress
                git config --global https.proxy $ProxySocketAddress
            } else {
                Write-Host "Disabling Git proxy settings..." -ForegroundColor Red
                git config --global --unset http.proxy
                git config --global --unset https.proxy
            }
        } catch {
            Write-Error "An error occurred while toggling Git proxy settings: $_"
        }
    }

    end {
        Write-Host "Git proxy settings toggled successfully!"
    }
}