:: ============================================================================
:: ZF2 CLI Helper - Workcopy Status Script
::
:: This script displays git status for [app-main] and all the sub-modules
:: [mod-*] that are loaded under [app-main]
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
set PATH=!PATH!;C:\Program Files (x86)\Git\cmd\
set PATH=!PATH!;C:\Program Files (x86)\Zend\ZendServer\bin\

echo.
echo *** Currently at directory [%SRC_PATH%] ***

echo.
echo ((( Updating composer.phar ))) -^> -^> -^>
echo.
php composer.phar self-update

echo.
echo ((( Listing changes under [app-main] ))) -^> -^> -^>
echo.
git status

echo.
echo ((( Listing changes in all the sub-modules ))) -^> -^> -^>
echo.
php composer.phar status -v
