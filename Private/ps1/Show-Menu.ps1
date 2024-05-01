function Show-Menu {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string[]]$Options,
        $CurrentProxyStatus
    )

    $selectedOption = 0

    while ($true) {
        Clear-Host

        Write-Host "`e[38;2;52;152;219m╭──────----────────────────----------------------─────────────────────╮`e[0m"
        Write-Host "`e[38;2;52;152;219m│                          UoR-FoE Proxy Config                       │`e[0m"
        Write-Host "`e[38;2;52;152;219m╰──────----────────────────----------------------─────────────────────╯`e[0m"
        Write-Host ""
        if ($CurrentProxyStatus) {
            Write-Host "    `e[38;2;46;204;113mCURRENT PROXY STATUS:`e[0m"
            foreach ($key in $CurrentProxyStatus.Keys) {
                Write-Host "        $($CurrentProxyStatus[$key])"
            }
            Write-Host ""
        }
        Write-Host "    `e[38;2;46;204;113mTO TOGGLE PROXY SETTINGS:`e[0m"
        Write-Host "    Use the arrow keys to select an option and press Enter to confirm."
        Write-Host ""
    
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selectedOption) {
                Write-Host "    `e[38;2;241;196;15m      ╰►  $($Options[$i])`e[0m"
            } else {
                Write-Host "    `e[38;2;236;240;241m      |  $($Options[$i])`e[0m"
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
            81 {  # 'q' key
                return "Exit(q)"
            }
        }
        Clear-Host
    }
}