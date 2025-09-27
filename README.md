# UoR-FOE Proxy Configuration Module

## Overview

The UoR-FOE Proxy Configuration Module is designed to help students and staff of the Faculty of Engineering, University of Ruhuna, easily toggle proxy settings for NPM, Git, and Windows. This module provides a set of PowerShell functions to manage proxy settings, making it easier to switch between different proxy configurations.

## Installation

To install the UoR-FOE Proxy Configuration Module, follow these steps:

1. Clone the repository to your local machine:
   ```sh
   git clone https://github.com/Sathursan-S/UorProxyConfig.git
   ```

2. Navigate to the repository directory:
   ```sh
   cd UorProxyConfig
   ```

3. Import the module into your PowerShell session:
   ```sh
   Import-Module .\UorProxyConfig.psd1
   ```

4. Verify that the module is imported successfully:
   ```sh
   Get-Module -Name UorProxyConfig
   ```

### Installation from PowerShell Gallery

You can also install the UoR-FOE Proxy Configuration Module from the PowerShell Gallery:

1. Open PowerShell with administrative privileges.

2. Run the following command to install the module:
   ```sh
   Install-Module -Name UorProxyConfig -Repository PSGallery
   ```

3. Verify that the module is installed successfully:
   ```sh
   Get-Module -Name UorProxyConfig
   ```
4. If error occurs with the current Execution Policy:
   ```sh
   Set-ExecutionPolicy RemoteSigned
   ```

## Usage

### Switch-Proxy Function

The `Switch-Proxy` function provides a user interface for toggling proxy settings for NPM, Git, and Windows. It allows you to easily switch between different proxy configurations.

#### Example Usage

1. Run the `Switch-Proxy` function:
   ```sh
   Switch-Proxy
   ```

2. Follow the on-screen instructions to toggle proxy settings. Use the arrow keys to select an option and press Enter to confirm.

#### Expected Output

When you run the `Switch-Proxy` function, you will see a menu with the following options:

```
╭──────----────────────────----------------------─────────────────────╮
│                          UoR-FoE Proxy Config                       │
╰──────----────────────────----------------------─────────────────────╯

    CURRENT PROXY STATUS:
        Proxy Server  : http://10.50.225.222:3128
        Global        : Enabled
        NPM           : Enabled
        Git           : Enabled
        Proxy Env-Var : http://10.50.225.222:3128

    TO TOGGLE PROXY SETTINGS:
    Use the arrow keys to select an option and press Enter to confirm.

        ╰►  Toggle Global Proxy
        |  Toggle Git Proxy
        |  Toggle NPM Proxy
        |  Exit(q)
```

Select the desired option to toggle the corresponding proxy settings.

## Functions

### Get-CurrentProxyStatus

This function retrieves the current proxy status for NPM, Git, and Windows.

#### Parameters

- None

#### Example Usage

```sh
$currentProxyStatus = Get-CurrentProxyStatus
```

### Show-CurrentProxyStatus

This function displays the current proxy status for NPM, Git, and Windows.

#### Parameters

- None

#### Example Usage

```sh
Show-CurrentProxyStatus
```

### Switch-Git-Proxy

This function toggles the Git proxy settings.

#### Parameters

- `ProxySocketAddress` (Mandatory): The proxy server address to set.

#### Example Usage

```sh
Switch-Git-Proxy -ProxySocketAddress "http://10.50.225.222:3128"
```

### Switch-Global-Proxy

This function toggles the global proxy settings for Windows.

#### Parameters

- `ProxySocketAddress` (Mandatory): The proxy server address to set.

#### Example Usage

```sh
Switch-Global-Proxy -ProxySocketAddress "http://10.50.225.222:3128"
```

### Switch-Npm-Proxy

This function toggles the NPM proxy settings.

#### Parameters

- `ProxySocketAddress` (Mandatory): The proxy server address to set.

#### Example Usage

```sh
Switch-Npm-Proxy -ProxySocketAddress "http://10.50.225.222:3128"
```
