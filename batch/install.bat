:: ============================================================================
:: ZF2 CLI Helper - Installation Script
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
set CFG_PATH=%SRC_PATH%\config\autoload\
set PUB_PATH=%SRC_PATH%\public\
set ENV_NAME=development

echo %PATH%|findstr /i git >nul:
if %errorlevel% == 1 (
    set PATH=!PATH!;"C:\Program Files (x86)\Git\cmd\"
    set PATH=!PATH!;"C:\Program Files (x86)\Zend\ZendServer\bin\"
)

echo [Install] Updating Composer...
echo -----------------------------------------------
php composer.phar self-update
echo -----------------------------------------------

echo [Install] Copying [local.php.dist-%ENV_NAME%] to [local.php]...
copy %CFG_PATH%local.php.dist-%ENV_NAME% %CFG_PATH%local.php
echo [Install] Copying [.htaccess.dist-%ENV_NAME%] to [.htaccess]...
copy %PUB_PATH%.htaccess.dist-%ENV_NAME% %PUB_PATH%.htaccess
echo [Install] Copying [composer.json.dist-%ENV_NAME%] to [composer.json]...
copy %SRC_PATH%\composer.json.dist-%ENV_NAME% %SRC_PATH%\composer.json

if not exist %SRC_PATH%\composer.lock (
    echo [Install] Installing sub-packages...
    echo -----------------------------------------------
    php composer.phar install
    echo -----------------------------------------------
) else (
    echo [Install] Updating sub-packages...
    echo -----------------------------------------------
    php composer.phar update
    echo -----------------------------------------------
)

echo [Install] *DONE* :))
