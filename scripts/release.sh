#!/bin/bash

set -euo pipefail

version="${1:?version required}"

bosh upload-blobs

git add .
git ci -m "Upload blobs for release $version"

bosh create-release --version="$version" --final --tarball="garden-windows-tools-$version.tgz"

git add .
git ci -m "Release $version"

git push

gh release create "$version" "./garden-windows-tools-$version.tgz"
rm "./garden-windows-tools-$version.tgz"

echo "Now update the concourse ops file to point to: https://github.com/masters-of-cats/garden-windows-tools-release/releases/download/$version/garden-windows-tools-$version"
