#!/usr/bin/env bash

if [ -z "${BASH_VERSINFO[0]}" ]; then
  echo -e "\nERROR: BASH_VERSINFO not accessible, invalid environment\n"
elif f [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
  echo -e "\nERROR: BASH Major Version: ${BASH_VERSINFO[0]} Full Version ${BASH_VERSION}\n"
  echo -e "\nERROR: BASH Version > 4.x Required\n"
  exit 1
fi

if [[ ! -a .ciignore ]]; then
  echo ".ciignore doesn't exist! Nothing to do here!"
  exit 0
else
  mapfile -t changes < "${@}"
  mapfile -t blacklist < .ciignore
fi

for i in "${blacklist[@]}"
do
	# Remove the current pattern from the list of changes
	changes=( "${changes[@]/$i/}" )

	if [[ "${#changes[@]}" -eq 0 ]]; then
		# If we've exhausted the list of changes before we've finished going
		# through patterns, that's okay, just quit the loop
		break
	fi
done

if [[ ${#changes[@]} -gt 0 ]]; then
  # If there's still changes left, then we have stuff to build, leave the commit alone.
  exit 0
fi

# Prefix the commit message with "[skip ci]"
sed -i '1s/^/[skip ci] /' "$1"
