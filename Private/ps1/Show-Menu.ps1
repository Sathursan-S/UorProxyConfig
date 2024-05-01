function Show-Menu {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string[]]$Options,
        $CurrentProxyStatus
    )

    $selectedOption = 0

    while ($true) {
        Clear-Host

        Write-Host "╭──────----────────────────----------------------─────────────────────╮" -ForegroundColor Cyan
        Write-Host "│                          UoR-FoE Proxy Config                       │" -ForegroundColor Cyan
        Write-Host "╰──────----────────────────----------------------─────────────────────╯" -ForegroundColor Cyan
        Write-Host ""
        if ($null -ne $CurrentProxyStatus) {
            Write-Host "    CURRENT PROXY STATUS:" -ForegroundColor Green
            foreach ($key in $CurrentProxyStatus.Keys) {
                Write-Host "        $($CurrentProxyStatus[$key])" 
            }
            Write-Host ""
        }
        
        Write-Host "    TO TOGGLE PROXY SETTINGS:" -ForegroundColor Green
        Write-Host "    Use the arrow keys to select an option and press Enter to confirm."
        Write-Host ""
    
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selectedOption) {
                Write-Host "        ╰►  $($Options[$i])" -ForegroundColor Yellow
            } else {
                Write-Host "        |  $($Options[$i])" -ForegroundColor White
            }
        }    

        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            38 {  # Up arrow
                $selectedOption = ($selectedOption - 1 + $Options.Count) % $Options.Count
            }
            40 {  # Down arrow
                $selectedOption = ($selectedOption + 1) % $Options.Count
            }
            13 {  # Enter key
                return $Options[$selectedOption]
            }
            81 {  # q key
                return "Exit(q)"
            }
        }
        Clear-Host
    }
}
