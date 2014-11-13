:: ============================================================================
:: ZF2 CLI Helper - Module Creation Script
::
:: @link      https://github.com/waltzofpearls/zf2-cli-helper
:: @copyright Copyright (c) 2014 Topbass Labs (topbasslabs.com)
:: @author    Waltz.of.Pearls <rollie@topbasslabs.com, rollie.ma@gmail.com>
:: ============================================================================

@echo off
setlocal enabledelayedexpansion

set SRC_PATH=%cd%
if %SRC_PATH:~-4% == \bin (
    cd %SRC_PATH%\..\
)
set SRC_PATH=%cd%
