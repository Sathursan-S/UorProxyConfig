function Switch-Global-Proxy {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProxySocketAddress
    )
    
    begin {
        $registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
        $registryName = "ProxyEnable"
        $proxyEnable = (Get-ItemProperty -Path $registryPath -Name $registryName).$registryName
        $env:HTTP_PROXY = $ProxySocketAddress
        $env:HTTPS_PROXY = $ProxySocketAddress
    }

    process {
        try {
            if ($proxyEnable -eq 1) {
                Write-Host "Disabling global proxy settings..." -ForegroundColor Red
                Set-ItemProperty -Path $registryPath -Name $registryName -Value 0

                Remove-NpmProxy
                Remove-GitProxy

                [Environment]::SetEnvironmentVariable("HTTP_PROXY", "", "User")
                [Environment]::SetEnvironmentVariable("HTTPS_PROXY", "", "User")

                $proxyEnable = 0
            } else {
                Write-Host "Enabling global proxy settings..." -ForegroundColor Green
                Set-ItemProperty -Path $registryPath -Name $registryName -Value 1
                Set-ItemProperty -Path $registryPath -Name "ProxyServer" -Value $ProxySocketAddress
                Write-Host "Proxy server set to $ProxySocketAddress" -ForegroundColor Green

                [Environment]::SetEnvironmentVariable("HTTP_PROXY", $ProxySocketAddress, "User")
                [Environment]::SetEnvironmentVariable("HTTPS_PROXY", $ProxySocketAddress, "User")

                Set-NpmProxy -ProxySocketAddress $ProxySocketAddress
                Set-GitProxy -ProxySocketAddress $ProxySocketAddress

                $proxyEnable = 1
            }
        } catch {
            Write-Host "An error occurred while toggling global proxy settings: $_" -ForegroundColor Red
        }
    }
    
    end {
        Write-Host "Global proxy settings toggled successfully!"
    }
}