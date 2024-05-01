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
                Write-Host "Enabling NPM proxy settings..." -ForegroundColor Green
                npm config set proxy $ProxySocketAddress
                npm config set https-proxy $ProxySocketAddress
            } else {
                Write-Host "Disabling NPM proxy settings..." -ForegroundColor Red
                npm config delete proxy
                npm config delete https-proxy
            }
        } catch {
            Write-Error "An error occurred while toggling NPM proxy settings: $_"
        }
    }

    end {
        Write-Host "NPM proxy settings toggled successfully!"
    }
}