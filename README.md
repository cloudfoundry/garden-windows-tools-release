# Garden Windows Tools BOSH Release

This provides golang for windows, at a version that the garden team can
control.  It is used in the concourse deployment, to supply golang to the
windows-worker.

## How to bump golang

1. Download the latest golang for windows from https://golang.org/dl/
1. `bosh add-blob ./go$VERSION.windows.amd64.zip golang-1-windows/go$VERSION.windows-amd64.zip`
1. Update `packages/golang-1-windows/packaging` and `packages/golang-1-windows/spec` to refer to the new golang version
1. Remove the old blob from `config/blobs.yml`
1. Run `./scripts/release.sh` to create a new release
1. Update the garden-windows-tools release version and URL in the concourse windows ops file.
