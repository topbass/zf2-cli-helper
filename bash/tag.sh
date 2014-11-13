#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Tagging Script
#
# This script can view and create git tags for [app-main] and all the
# sub-modules [mod-*] that are loaded under [app-main]
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
