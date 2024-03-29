#!/bin/sh

epm tool eget https://raw.githubusercontent.com/alt-autorepacked/common/v0.3.0/common.sh
. ./common.sh

_package="google-chrome-stable"
_download_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

_download() {
    real_download_url=$(epm tool eget --get-real-url $_download_url)
    epm -y repack "$real_download_url"
}

_download
_add_repo_suffix
download_version=$(_check_version_from_download)
remote_version=$(_check_version_from_remote)

if [ "$remote_version" != "$download_version" ]; then
    TAG="v$download_version"
    _create_release
    echo "Release created: $TAG"
else
    echo "No new version to release. Current version: $download_version"
fi

rm common.sh