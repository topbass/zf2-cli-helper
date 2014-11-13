#! /bin/bash

# ============================================================================
# ZF2 CLI Helper - Installation Script
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
CFG_PATH="${SRC_PATH}/config"
PUB_PATH="${SRC_PATH}/public"
ENV_NAME="development"
ECO_PREPEND_EXT=""
ECO_PREPEND_INT="[Install]"
RUN_TESTS="NO"
RUN_BUILD="NO"

while [ "$#" -gt "0" ]; do
    case $1 in
        -e|--environment)
            shift
            ENV_NAME=$1
            ;;
        -p|--prepend)
            shift
            ECO_PREPEND_EXT=$1
            ;;
        -b|--build)
            RUN_BUILD="YES"
            ;;
        -t|--test)
            RUN_TESTS="YES"
            ;;
    esac
    shift
done

echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Updating Composer..."
echo "-----------------------------------------------"
php composer.phar self-update
echo "-----------------------------------------------"

echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Copying [application.php.dist-${ENV_NAME}] to [application.php]..."
cp -f "${CFG_PATH}/application.php.dist-${ENV_NAME}" "${CFG_PATH}/application.php"
echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Copying [local.php.dist-${ENV_NAME}] to [local.php]..."
cp -f "${CFG_PATH}/autoload/local.php.dist-${ENV_NAME}" "${CFG_PATH}/autoload/local.php"
echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Copying [.htaccess.dist-${ENV_NAME}] to [.htaccess]..."
cp -f "${PUB_PATH}/.htaccess.dist-${ENV_NAME}" "${PUB_PATH}/.htaccess"
echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Copying [composer.json.dist-${ENV_NAME}] to [composer.json]..."
cp -f "${SRC_PATH}/composer.json.dist-${ENV_NAME}" "${SRC_PATH}/composer.json"

if [ ! -f "${SRC_PATH}/composer.lock" ]; then
    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Setting up file mode to specific folders..."
    chmod -R 0777 data
    chmod 0755 vendor module
    chmod 0755 composer.phar
    chmod 0755 bin/install.sh bin/update.sh bin/status.sh bin/tag.sh bin/module.sh

    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Installing sub-packages..."
    echo "-----------------------------------------------"
    php composer.phar install
    echo "-----------------------------------------------"
else
    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Updating sub-packages..."
    echo "-----------------------------------------------"
    php composer.phar update
    echo "-----------------------------------------------"
fi

# run build commands for js and css if -b|--build option is given
if [ "$RUN_BUILD" == "YES" ]; then
    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Packing and compiling js and css files..."
    php public/index.php bundle js
    php public/index.php bundle css
fi

# run unit tests if -t|--test option is given
if [ "$RUN_TESTS" == "YES" ]; then
    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} Running unit test suites..."
    echo "-----------------------------------------------"
    php public/index.php test all
    ERR_CODE=$?
    echo "-----------------------------------------------"
    # break and exit if tests fail
    if [ ! "$ERR_CODE" == "0" ]; then
        echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} *ERROR* Oops, there is some problem in the unit tests. Fix it and re-run the script."
        exit $ERR_CODE
    fi
    echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} All tests passed. Good job!"
fi

echo "${ECO_PREPEND_EXT}${ECO_PREPEND_INT} *DONE* installation process completed :))"