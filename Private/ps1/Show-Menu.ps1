function Show-Menu {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string[]]$Options
    )

    $selectedOption = 0

    while ($true) {
        Clear-Host

        Write-Host "╭──────────────────────----------------------─────────────────────╮"
        Write-Host "│                      UoR-FoE Proxy Config                       │"
        Write-Host "╰──────────────────────----------------------─────────────────────╯"
        Write-Host ""
        Write-Host " TO TOGGLE PROXY SETTINGS:"
        Write-Host " Use the arrow keys to select an option and press Enter to confirm."
        write-host ""

        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selectedOption) {
                Write-Host "      ► $($Options[$i])" -ForegroundColor Blue
            }
            else {
                Write-Host "        $($Options[$i])"
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
        }
        Clear-Host
    }
}