#!/bin/bash

NAME=$(python3 -c 'print(eval(open("package").read())["name"])')
VERSION=$(python3 -c 'print(eval(open("package").read())["version"])')
rm -f $NAME-$VERSION.mkp \
   /omd/sites/cmk/var/cat  check_mk/packages/${NAME}-*.mkp \
   /omd/sites/cmk/var/check_mk/packages_local/${NAME}-*.mkp ||:

mkp -v package package 2>&1 | sed '/Installing$/Q' ||:

cp /omd/sites/cmk/var/check_mk/packages_local/$NAME-$VERSION.mkp .

mkp inspect $NAME-$VERSION.mkp

# Set Outputs for GitHub Workflow steps
if [ -n "$GITHUB_WORKSPACE" ]; then
    echo "pkgfile=${NAME}-${VERSION}.mkp" >> $GITHUB_OUTPUT
    echo "pkgname=${NAME}" >> $GITHUB_OUTPUT
    echo "pkgversion=$VERSION" >> $GITHUB_OUTPUT
fi