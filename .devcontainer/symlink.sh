#!/bin/bash

for DIR in 'agents' 'checkman' 'checks' 'doc' 'inventory' 'notifications' 'pnp-templates' 'web'; do
    rm -rfv $OMD_ROOT/local/share/check_mk/$DIR
    ln -sv $WORKSPACE/$DIR $OMD_ROOT/local/share/check_mk/$DIR
done;

rm -rfv $OMD_ROOT/local/lib/check_mk/base/plugins/agent_based
ln -sv $WORKSPACE/agent_based $OMD_ROOT/local/lib/check_mk/base/plugins/agent_based

rm -rfv $OMD_ROOT/local/lib/nagios/plugins
ln -sv $WORKSPACE/nagios_plugins $OMD_ROOT/local/lib/nagios/plugins