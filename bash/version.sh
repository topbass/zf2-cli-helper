#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Release Version Extraction Script
#
# @link      https://github.com/waltzofpearls/zf2-cli-helper
# @copyright Copyright (c) 2014 Topbass Labs (topbasslabs.com)
# @author    Waltz.of.Pearls <rollie@topbasslabs.com, rollie.ma@gmail.com>
# ============================================================================

git log --pretty=oneline | head -1 | awk '{print $1}'
