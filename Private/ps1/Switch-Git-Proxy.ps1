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
                Set-GitProxy -ProxySocketAddress $ProxySocketAddress
            } else {
                Remove-GitProxy
            }
        } catch {
            Write-Error "An error occurred while toggling Git proxy settings: $_"
        }
    }

    end {
        Write-Host "Git proxy settings toggled successfully!"
    }
}

function Set-GitProxy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProxySocketAddress
    )

    try {
        Write-Host "Setting Git proxy settings..." -ForegroundColor Green
        git config --global http.proxy $ProxySocketAddress
        git config --global https.proxy $ProxySocketAddress
    } catch {
        throw "An error occurred while setting Git proxy settings: $_"
    }
}

function Remove-GitProxy {
    try {
        Write-Host "Unsetting Git proxy settings..." -ForegroundColor Red
        git config --global --unset http.proxy
        git config --global --unset https.proxy
    } catch {
        throw "An error occurred while unsetting Git proxy settings: $_"
    }
}