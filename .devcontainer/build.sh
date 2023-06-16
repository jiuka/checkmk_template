#!/bin/bash

NAME=$(python3 -c 'print(eval(open("package").read())["name"])')
rm /omd/sites/cmk/var/check_mk/packages/* ||:
rm /omd/sites/cmk/var/check_mk/packages_local/* ||:

mkp -v package package ||:
cp /omd/sites/cmk/var/check_mk/packages_local/*.mkp .

# Set Outputs for GitHub Workflow steps
if [ -n "$GITHUB_WORKSPACE" ]; then
    echo "pkgfile=$(ls *.mkp)" >> $GITHUB_OUTPUT
    echo "pkgname=${NAME}" >> $GITHUB_OUTPUT
    VERSION=$(python3 -c 'print(eval(open("package").read())["version"])')
    echo "pkgversion=$VERSION" >> $GITHUB_OUTPUT
fi