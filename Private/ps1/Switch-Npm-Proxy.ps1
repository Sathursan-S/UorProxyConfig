function Switch-Npm-Proxy {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProxySocketAddress
    )

    begin {
        $npmProxyStatus = npm config get proxy
        Write-Host "Current NPM proxy settings: $npmProxyStatus"
    }

    process {
        try {
            if ($npmProxyStatus -eq "null") {
                Set-NpmProxy -ProxySocketAddress $ProxySocketAddress
            } else {
                Remove-NpmProxy
            }
        } catch {
            Write-Error "An error occurred while toggling NPM proxy settings: $_"
        }
    }

    end {
        Write-Host "NPM proxy settings toggled successfully!"
    }
}

function Set-NpmProxy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProxySocketAddress
    )

    try {
        Write-Host "Setting NPM proxy settings..." -ForegroundColor Green
        npm config set proxy $ProxySocketAddress
        npm config set https-proxy $ProxySocketAddress
    } catch {
        throw "An error occurred while setting NPM proxy settings: $_"
    }
}

function Remove-NpmProxy {
    try {
        Write-Host "Unsetting NPM proxy settings..." -ForegroundColor Red
        npm config delete proxy
        npm config delete https-proxy
    } catch {
        throw "An error occurred while unsetting NPM proxy settings: $_"
    }
}