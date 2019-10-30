#!/bin/bash

set -e

# The following line is needed by the CircleCI Local Build Tool (due to Docker interactivity)
exec < /dev/tty

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

exit_status=0

if ! command -v circleci; then
    echo "circleci must be installed!"
    exit_status=1
fi

# If validation fails, tell Git to stop and provide error message. Otherwise, continue.
if ! error_message=$(circleci config validate -c "$@"); then
	echo "CircleCI Configuration Failed Validation."
	echo "$error_message"
	exit_status=1
fi

exit $exit_status
