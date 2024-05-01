function Switch-Proxy {
    while($true){
        # $ProxySocketAddress = Read-Host "Enter the proxy server address (e.g. http://proxy.example.com:8080)"
        $ProxySocketAddress = "http://10.50.225.222:3128"
        $proxyOptions = @(
            "Toggle Global Proxy", 
            "Toggle Git Proxy", 
            "Toggle NPM Proxy", 
            "Exit"
            )
        $selectedOption = Show-Menu -Options $proxyOptions

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
            "Exit" {
                Write-Host "Exiting..." -ForegroundColor Red
                exit
                break
            }
        }
        
        Write-Host ""
        Write-Host "Press any key to continue..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}