#!/bin/bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

exit_status=0

if ! command -v hadolint; then
    echo "hadolint must be installed!"
    exit_status=1
fi

hadolint "$@"
exit_status=$?

exit $exit_status
