#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Testing Script
#
# This script will run unit test suites for all the sub-modules under
# ./module folder. Unit tests are powered by PHPUnit
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

php ./public/index.php test all

if [ ! "$?" == "0" ]; then
    echo "[Test] Oops, test failed. Fix the problem and test again (:("
else
    echo "[Test] *DONE* All tests passed :))"
fi
