#!/bin/bash

# to set an external diff tool run 
#
# git config --global diff.external $EXTERNAL_DIFF_TOOL
EXTERNAL_DIFF_TOOL=meld


# meld will complain about bad arguments being passed by git so create a 
# wrapper script like this to pass the arguments the tool (meld) needs.
# set it up by running: 
#
# git config --global diff.external ~/.env-config/external_diff.sh
#
# it will override the previous command.

$EXTERNAL_DIFF_TOOL $2 $5
