#!/bin/bash

NAME=$(python -c 'print(eval(open("package").read())["name"])')
rm /omd/sites/cmk/var/check_mk/packages/* ||:
ln -s $WORKSPACE/package /omd/sites/cmk/var/check_mk/packages/$NAME

mkp -v pack $NAME