<#
.SYNOPSIS
    Install / cleanup the neovim configuration on Windows.

.DESCRIPTION
    PowerShell counterpart of install.sh (Linux). On Windows nothing is
    extracted from the bundled tar.bz2 packs: config/lazy, config/mason and
    config/dap only ship Linux builds. lazy.nvim is bootstrapped from GitHub
    on first nvim start, Mason installs native Windows servers itself, and
    this script reports which helper tools you need on PATH.

.EXAMPLE
    ./install.ps1 -Option install -All
    ./install.ps1 -Option install -Config -InstallPath D:\dev\nvim
    ./install.ps1 -Option cleanup -All
#>
[CmdletBinding()]
param(
    [ValidateSet("install", "cleanup", "help")]
    [string]$Option = "help",
    [string]$InstallPath = "",
    [switch]$Config,
    [switch]$Lsp,
    [switch]$Tools,
    [switch]$All
)

$ErrorActionPreference = "Stop"

# Repo root (directory of this script)
$WORK = $PSScriptRoot

##############################
#     Utility helpers        #
##############################

function Show-Help {
    Write-Host "./install.ps1 -Option <install|cleanup> <switch>: select option and package" -ForegroundColor Cyan
    Write-Host "  -Option install : install nvim configuration into the selected directory"
    Write-Host "  -Option cleanup: remove nvim configuration from the selected directory"
    Write-Host "  -All   : all below options"
    Write-Host "  -Config: configuration only"
    Write-Host "  -Lsp   : note on LSP/DAP packs (skipped: they only ship Linux builds)"
    Write-Host "  -Tools : report required tools (no Linux binary is shipped on Windows)"
    Write-Host "  -InstallPath <dir>: deployment directory (default: ~\neovim)"
}

function Resolve-InstallPath {
    if ($InstallPath -eq "") {
        $InstallPath = Join-Path $HOME "neovim"
    } else {
        $InstallPath = $ExecutionContext.InvokeCommand.ExpandString($InstallPath)
    }
    if (-not (Test-Path -LiteralPath $InstallPath)) {
        New-Item -ItemType Directory -Force -Path $InstallPath | Out-Null
    }
    return (Resolve-Path -LiteralPath $InstallPath).Path
}

# Patch the NVIM_DOT_PATH fallback in the copied loader so nvim finds the profile.
function Patch-DotPath {
    param([string]$File, [string]$Path)
    $encoding = New-Object System.Text.UTF8Encoding($false)
    $text = [System.IO.File]::ReadAllText($File, $encoding)
    $pathed = $Path.Replace("\", "/")
    $text = $text.Replace('NVIM_DOT_PATH or "~/neovim"', ('NVIM_DOT_PATH or "' + $pathed + '"'))
    [System.IO.File]::WriteAllText($File, $text, $encoding)
}

##############################
#     Install               #
##############################

function Install-Config {
    param([string]$Path)
    $configDir = Join-Path $Path "config"
    New-Item -ItemType Directory -Force -Path $configDir | Out-Null

    # Configuration only. The config/lazy/mason/dap packs are Linux-only
    # tar.bz2 archives and are NOT extracted on Windows: lazy.nvim is cloned
    # by config/nvim/init.lua on first start, Mason installs its own binaries.
    Copy-Item -Recurse -Force -LiteralPath (Join-Path $WORK "config\nvim") -Destination $configDir

    # Loader -> nvim config dir on Windows (%LOCALAPPDATA%\nvim)
    $nvimConfig = Join-Path $env:LOCALAPPDATA "nvim"
    if (Test-Path -LiteralPath $nvimConfig) { Remove-Item -Recurse -Force -LiteralPath $nvimConfig }
    Copy-Item -Recurse -Force -LiteralPath (Join-Path $WORK "rtp") -Destination $nvimConfig

    # Point the loader profile at the deployment directory
    Patch-DotPath -File (Join-Path $nvimConfig "init.lua") -Path $Path

    # Old cache
    $nvimData = Join-Path $env:LOCALAPPDATA "nvim-data"
    if (Test-Path -LiteralPath $nvimData) { Remove-Item -Recurse -Force -LiteralPath $nvimData }

    Write-Host "[DONE] Installed configuration to $Path" -ForegroundColor Green
}

function Install-Lsp {
    Write-Host "The config/lazy, config/mason and config/dap tar.bz2 packs ship Linux builds only." -ForegroundColor Yellow
    Write-Host "On Windows they are skipped:" -ForegroundColor Yellow
    Write-Host "  - lazy.nvim       cloned by config/nvim/init.lua on first start" -ForegroundColor Yellow
    Write-Host "  - Mason servers   installed natively by :Mason on first start" -ForegroundColor Yellow
    Write-Host "  - DAP debuggers   installed natively by :Mason (e.g. cpptools, lldb)" -ForegroundColor Yellow
    Write-Host "[DONE] No Linux pack extracted. Nothing to install." -ForegroundColor Green
}

function Install-Tools {
    Write-Host "The bundled tools/ tree contains Linux binaries and cannot run on Windows." -ForegroundColor Yellow
    Write-Host "Install the required tools and make sure they are on PATH:" -ForegroundColor Yellow
    $required = [ordered]@{
        git     = "Git.Git"
        rg      = "BurntSushi.ripgrep.MSVC"
        fd      = "sharkdp.fd"
        fzf     = "junegunn.fzf"
        lazygit = "JesseDuffield.lazygit"
        python  = "Python.Python.3.12"
        node    = "OpenJS.NodeJS.LTS"
    }
    foreach ($k in $required.Keys) {
        if (Get-Command $k -ErrorAction SilentlyContinue) {
            Write-Host ("  [OK]   {0}" -f $k) -ForegroundColor Green
        } else {
            Write-Host ("  [MISS] {0}  ->  winget install {1}" -f $k, $required[$k]) -ForegroundColor Red
        }
    }
    Write-Host "  (pynvim: python -m pip install pynvim | nvr: npm install -g neovim)" -ForegroundColor DarkGray
    Write-Host "[DONE] Tool report finished. Nothing was installed." -ForegroundColor Green
}

##############################
#     Cleanup               #
##############################

function Cleanup-Config {
    param([string]$Path)
    foreach ($d in @((Join-Path $env:LOCALAPPDATA "nvim"), (Join-Path $env:LOCALAPPDATA "nvim-data"))) {
        if (Test-Path -LiteralPath $d) { Remove-Item -Recurse -Force -LiteralPath $d; Write-Host "[DONE] Removed $d" }
    }
    foreach ($d in @((Join-Path $Path "config\nvim"), (Join-Path $Path "config\lazy"))) {
        if (Test-Path -LiteralPath $d) { Remove-Item -Recurse -Force -LiteralPath $d; Write-Host "[DONE] Removed $d" }
    }
}

function Cleanup-Lsp {
    param([string]$Path)
    foreach ($d in @((Join-Path $Path "config\mason"), (Join-Path $Path "config\dap"))) {
        if (Test-Path -LiteralPath $d) { Remove-Item -Recurse -Force -LiteralPath $d; Write-Host "[DONE] Removed $d" }
    }
    $configDir = Join-Path $Path "config"
    if ((Test-Path -LiteralPath $configDir) -and -not (Get-ChildItem -LiteralPath $configDir -Force)) {
        Remove-Item -LiteralPath $configDir
    }
}

function Cleanup-Tools {
    # nothing persistent is created on Windows (no PATH patching)
    Write-Host "[DONE] No persisted tool state to remove"
}

##############################
#     Main                  #
##############################

switch ($Option) {
    "install" {
        if (-not (Test-Path (Join-Path $WORK "rtp")) -or -not (Test-Path (Join-Path $WORK "config"))) {
            throw "Missing packages. Please check the repository layout."
        }
        $path = Resolve-InstallPath
        # Clean environment before installing (mirrors install.sh)
        if ($All -or $Config) { Cleanup-Config -Path $path }
        if ($All -or $Lsp)    { Cleanup-Lsp -Path $path }
        if ($All -or $Tools)  { Cleanup-Tools }
        if ($All -or $Config) { Install-Config -Path $path }
        if ($All -or $Lsp)    { Install-Lsp -Path $path }
        if ($All -or $Tools)  { Install-Tools }
    }
    "cleanup" {
        $path = Resolve-InstallPath
        if ($All -or $Config) { Cleanup-Config -Path $path }
        if ($All -or $Lsp)    { Cleanup-Lsp -Path $path }
        if ($All -or $Tools)  { Cleanup-Tools }
    }
    default {
        Show-Help
    }
}