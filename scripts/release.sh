#!/bin/bash

set -euo pipefail

version="${1:?version required}"

golangVersion="$(gawk 'match($0, /^golang-1-windows\/go(.*).windows-amd64.zip/, v) {print v[1]}' config/blobs.yml)"

lpass show Shared-Garden/windows-tools-release-s3-private-yml --notes > config/private.yml

bosh upload-blobs

git add .
git ci -m "Bump golang to v$golangVersion"

bosh create-release --version="$version" --final --tarball="garden-windows-tools-$version.tgz"

git add .
git ci -m "Release $version"

git push

gh release create "$version" --notes "golang-v$golangVersion" --target $(git rev-parse HEAD) "./garden-windows-tools-$version.tgz"
rm "./garden-windows-tools-$version.tgz"

echo "Now update the concourse ops file to point to: https://github.com/masters-of-cats/garden-windows-tools-release/releases/download/$version/garden-windows-tools-$version.tgz"
