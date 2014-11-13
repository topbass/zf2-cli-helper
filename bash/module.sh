#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Module Creation Script
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

# - create new module
#   (./module.sh create -n|--name [name] -s|--short-display [display name short] -l|--long-display [display name long])
#   + input
#     * module name
#     * module display name short
#     * module display name long
#   + stash restful api
#     * check if module repo exists (proceed if doesn't exist)
#     * create new module
#   + git checkout the new module's repo
#   + git checkout template module
#   + in template module folder
#     * remove .git folder
#     * replace module name in skel to the new module's name
#     * change module name in composer.json
#   + in the new module's folder
#     * copy everything from template module to here
#     * git add, check in and push changes
#   + remove template module folder and the new module's folder
#   + in app's main folder
#     * add the new module to composer.json
#     * add the new module to applicaiton.config.php
#     * do a composer update
#       (check in changes in all the modules or use 's' (stash) option)
#
# - change module name
#   (./module.sh rename -n|--name [name] -s|--short-display [display name short] -l|--long-display [display name long])
#   + input
#     * module name
#     * [optional] module display name short
#     * [optional] module display name long
#   + stash restful api
#     * check if module repo exists (proceed if exists)
#     * rename module repo
#   + in app's main folder
#     * change module name in composer.json
#     * change module name in application.php
#     * do a composer update
#       (check in changes in all the modules or use 's' (stash) option)
#     * remove the old module folder
#     * change module name in the new module folder
#     * [options] change module display names in the new module folder
#
# - delete module (in app's main folder)
#   (./module.sh delete -n|--name [name])
#   + input
#     * module name
#   + remove module from composer.json
#   + remove module from application.php
#   + remove module folder
