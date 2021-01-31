#!/bin/bash

for DIR in 'agents' 'checkman' 'checks' 'doc' 'inventory' 'notifications' 'pnp-templates' 'web'; do
    rm -rfv $OMD_ROOT/local/share/check_mk/$DIR
    ln -sv $WORKSPACE/$DIR $OMD_ROOT/local/share/check_mk/$DIR
done;

for DIR in 'agent_based'; do
    rm -rfv $OMD_ROOT/local/lib/check_mk/base/plugins/$DIR
    ln -sv $WORKSPACE/$DIR $OMD_ROOT/local/lib/check_mk/base/plugins/$DIR
done;