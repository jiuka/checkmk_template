#!/bin/bash

NAME=$(python -c 'print(eval(open("package").read())["name"])')
rm /omd/sites/cmk/var/check_mk/packages/* ||:
ln -s $WORKSPACE/package /omd/sites/cmk/var/check_mk/packages/$NAME

mkp -v pack $NAME

# Set Outputs for GitHub Workflow steps
if [ -n "$GITHUB_WORKSPACE" ]; then
    echo "::set-output name=pkgfile::$(ls *.mkp)"
    echo "::set-output name=pkgname::${NAME}"
    VERSION=$(python -c 'print(eval(open("package").read())["version"])')
    echo "::set-output name=pkgversion::$VERSION"
fi