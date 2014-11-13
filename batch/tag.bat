:: ============================================================================
:: ZF2 CLI Helper - Tagging Script
::
:: This script can view and create git tags for [app-main] and all the
:: sub-modules [mod-*] that are loaded under [app-main]
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
