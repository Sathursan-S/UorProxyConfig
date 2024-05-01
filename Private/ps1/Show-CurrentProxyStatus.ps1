function Show-CurrentProxyStatus {
    $CurrentProxyStatus = Get-CurrenProxyStatus

    if ($CurrentProxyStatus -eq $null) {
        Write-Host "`e[38;2;255;0;0mError: Unable to retrieve proxy status.`e[0m"
    } else {
        Write-Host "`e[38;2;46;204;113mCURRENT PROXY STATUS:`e[0m"
        foreach ($key in $CurrentProxyStatus.Keys) {
            Write-Host "$($CurrentProxyStatus[$key])"
        }
        Write-Host ""
    }
}