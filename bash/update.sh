#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Update Script
#
# @link      https://github.com/waltzofpearls/zf2-cli-helper
# @copyright Copyright (c) 2014 Topbass Labs (topbasslabs.com)
# @author    Waltz.of.Pearls <rollie@topbasslabs.com, rollie.ma@gmail.com>
# ============================================================================

SRC_PATH=$(pwd)
if [[ "$SRC_PATH" == *\bin ]]; then
    cd $(dirname "$SRC_PATH")
    SRC_PATH=$(pwd)
fi

echo "[Update] Updating composer.phar, app's main container and all the sub-modules..."
echo "   @directory: ${SRC_PATH}"

echo "[Status] Updating composer.phar..."
php composer.phar self-update
if [[ ! $(git status | grep -i composer.phar) == "" ]]; then
    CURRENT_BRANCH=$(git status | grep -i "on branch" | sed "s/#\s*on\s*branch\s*//i" | tr -d "\r\n")
    echo "[Status] Checking in and pushing new version composer.phar to git [${CURRENT_BRANCH}] branch..."
    git commit -m "Updated composer.phar [$(php composer.phar --version --no-ansi | tr -d "\r\n")]" composer.phar
    git push origin "$CURRENT_BRANCH"
fi

echo "[Update] Pulling changes app's main container..."
git pull origin master

echo "[Update] Running composer update..."
php composer.phar update

echo "[Update] *DONE* :))"
