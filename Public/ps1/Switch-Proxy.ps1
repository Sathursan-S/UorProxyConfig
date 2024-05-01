function Switch-Proxy {
    while($true){
        # $ProxySocketAddress = Read-Host "Enter the proxy server address (e.g. http://proxy.example.com:8080)"
        $ProxySocketAddress = "http://10.50.225.222:3128"
        $proxyOptions = @(
            "Toggle Global Proxy", 
            "Toggle Git Proxy", 
            "Toggle NPM Proxy", 
            "Exit(q)"
            )
        $currentProxyStatus = Get-CurrenProxyStatus
        $selectedOption = Show-Menu -Options $proxyOptions -CurrentProxyStatus $currentProxyStatus

        switch ($selectedOption) {
            "Toggle Global Proxy" {
                Switch-Global-Proxy -ProxySocketAddress $ProxySocketAddress
            }
            "Toggle Git Proxy" {
                Switch-Git-Proxy -ProxySocketAddress $ProxySocketAddress
            }
            "Toggle NPM Proxy" {
                Switch-Npm-Proxy -ProxySocketAddress $ProxySocketAddress
            }
            "Exit(q)" {
                Write-Host ""
                Write-Host "Press 'q' to`e[38;2;255;0;0m EXIT`e[0m or Press any key to continue..."
                $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
                if ($key -eq 81) {
                    Write-Host "Exiting..." -ForegroundColor Red
                    return
                }
            }
        }
    }
}