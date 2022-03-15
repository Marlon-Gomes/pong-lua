#!/usr/bin/env zsh
#######################################################################
# Copyright © 2022 Marlon de Oliveira Gomes.
# MIT License
#
# Project: Pong-Lua
# A remake of the classic Atari game Pong in Lua.
#
# File: build.sh
# Build utility for the project.
#
# Contact: 72144990+Marlon-Gomes@users.noreply.github.com
#######################################################################
VERSION=1.0
#######################################################################
# Main program                                                        #
#######################################################################
main() {
    echo "Project path: \n${PROJECT_DIR}"
    check_environment
    case $target in
        love)
            build_love;;
        macos)
            build_macos;;
        all)
            build_love && build_macos;;
    esac
}
#######################################################################
# Utilities                                                           #
#######################################################################
show_help()
(
    # Display help
    echo "Build utility for pong-lua."
    echo
    echo "Usage: ./build.sh [-c|h|t <args>|v]"
    echo "Options:"
    echo "        -c        Clean build folder"
    echo "        -h        Display this help"
    echo "        -t <args> Build for args (default all)"
    echo "        -v        Echo version"
    echo "Available arguments:"
    echo "love    Love"
    echo "macos   MacOSX"
    echo
)
#######################################################################
# Set variables                                                       #
#######################################################################
# Exit immediately if a command exits with a non-zero status
set -e

# Set the project's path as the directory containing this script
#PROJECT_DIR=$(cd "$(dirname "$0")"; pwd -P)
PROJECT_DIR="$(dirname "$0" | pwd -P )"
SRC_DIR="${PROJECT_DIR}/src"
BUILD_DIR="${PROJECT_DIR}/build"
TOOLS_DIR="${PROJECT_DIR}/tools"
APP_NAME="Pong-Lua"
LOVE_VERSION=11.4
#######################################################################
# Auxilliary functions                                                #
#######################################################################
check_environment() {
    # Check for the presence of main.lua
    if [ ! -f "${PROJECT_DIR}/main.lua" ]; then
        err "Error: Cannot find main.lua in the project's root directory"
        exit 1
    fi
    if [ ! -d "${SOURCE_DIR}/" ]; then
        err "Error: Cannot find source directory."
        exit 1
    fi
    if [ ! -d "${TOOLS_DIR}/" ]; then
        err "Error: Cannot find tools directory."
        exit 1
    fi
    if [ ! -d "${BUILD_DIR}" ]; then
        echo "Creating build directory."
        mkdir "${BUILD_DIR}"
    fi
}

clean_build() {
    # Subshell to preserve shell context
    (
        cd "${BUILD_DIR}"
        echo "Removing all files at $(pwd)"
        rm -rf ./*
    )
}

get_love_binaries() {
    # Target architecture
    local arch="macos"
    local download_url_prefix="https://github.com/love2d/love/releases/download"
    local download_url_suffix="${LOVE_VERSION}/love-${LOVE_VERSION}-${arch}.zip"
    echo "Downloading and extracting love binaries..."
    curl -OL "${download_url_prefix}/${download_url_suffix}"
    unzip -q "love-${LOVE_VERSION}-${arch}.zip"
    rm "love-${LOVE_VERSION}-${arch}.zip"
}

build_love() {
    # If target is given, use it. Otherwise use default.
    if [ $# -eq 0 ]; then
        local love_target_dir="${BUILD_DIR}/love"
    else
        local love_target_dir=$1
    fi
    echo "Creating a .love file at ${love_target_dir}"
    # Create the target directory if not existent
    mkdir -p "${love_target_dir}"
    # Create a temporary directory to hold build artifacts
    local love_build_dir=$(mktemp -d -t love-build-XXX)
    # Copy project directory to temporary directory
    cp -a "${PROJECT_DIR}/." "${love_build_dir}"
    # Change to a subshell to preserve current shell context
    (
        # Move to temporary build directory
        cd "${love_build_dir}"
        # Zip contents of the directory (recursively), in quiet mode
        # Ignore non-source files/directories
        zip -q -r "${APP_NAME}.love" ./* \
            -x '*.git*' "${BUILD_DIR}/*" '**/.DS_Store' "build.sh"
    )
    # Move contents of the temporary build directory to the target
    mv "${love_build_dir}/${APP_NAME}.love" "${love_target_dir}"
    echo "Removing temporary love build folders..."
    rm -rf "${love_build_dir}"
}

build_macos() {
    local macos_target_dir="${BUILD_DIR}/macos"
    mkdir -p ${macos_target_dir}
    echo "Building for MacOS..."
    local macos_build_dir=$(mktemp -d -t macos-build-XXX)
    echo "Staging MacOS build at ${macos_build_dir}"
    # Make the game into a .love file, inside build directory
    build_love "${macos_build_dir}/"
    # Switch to subshell to preserve pwd
    (
        # Change to temporary build directory
        cd "${macos_build_dir}"
        # Download and unzip love
        get_love_binaries
        # Copy game to love app resources
        echo "Creating app bundle..."
        cp "${APP_NAME}.love" "love.app/Contents/Resources"
        echo "Finishing touches..."
        cp -R "${TOOLS_DIR}/Pong-Lua.iconset" "love.app/Contents/Resources/"
        (
            cd "love.app/Contents/Resources/"
            # Remove existing icon packages
            rm -rf ./*.icns
            # Create new icon package
            iconutil -c icns "./Pong-Lua.iconset"
            # Remove iconset
            rm -rf ./*.iconset
        )
        cp -f "${TOOLS_DIR}/Info.plist" "love.app/Contents/"
        # Final archives
        mv "love.app" "${APP_NAME}.app"
        zip -ry -q "${APP_NAME}.zip" "${APP_NAME}.app"
    )
    mv "${macos_build_dir}/${APP_NAME}.zip" "${macos_target_dir}"
    echo "Removing staging area..."
    rm -rf "${macos_build_dir}"
    echo "Done!"
}

#######################################################################
# Process input options                                               #
#######################################################################
while getopts ":chvt:" option; do
    case $option in
        c) # Clean build folder
            clean_build
            exit;;
        h) # show help
            show_help
            exit;;
        v) # echo version
            echo "build.sh version ${VERSION}"
            exit;;
        t) # build for target
            if [ "${OPTARG}" = 'macos' ]; then
                target="macos"
            elif [ "${OPTARG}" = 'love' ]; then
                target="love"
            elif [ "${OPTARG}" = 'all' ]; then
                target="all"
            else
                echo "Invalid option."
                echo "Available options are:"
                echo "  all"
                echo "  macos"
                echo "  love"
                exit 1
            fi
            ;;
        \?) # Invalid option
            echo "Invalid option"
            echo "Available options are:"
            echo "  all (default)"
            echo "  macos"
            echo "  love"
            exit;;
    esac
done
if [ $OPTIND -eq 1 ]; then
    echo "No options were passed. Using default build (all)."
    target="all"
fi
shift $((OPTIND-1))
#######################################################################
# Execute                                                             #
#######################################################################
main "$@"
