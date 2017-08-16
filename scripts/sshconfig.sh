#!/bin/bash

. ./scripts/config.sh

echo 'create vagrant hosts to ansible inventory'

vagrant ssh-config > $SSHCONFIG_PATH
cat $SSHCONFIG_PATH \
    | grep "^Host\|HostName" \
    | sed 'N;s/\n/ /' \
    | awk 'match($4, /ec2-([0-9]*)-([0-9]*)-([0-9]*)-([0-9]*).*/, arr){ print $2 " eip=" arr[1]"."arr[2]"."arr[3]"."arr[4]}' \
    > $ANSIBLE_INVENTORY_PATH
echo 'ansible inventory is created.'

echo "-- inventory: $ANSIBLE_INVENTORY_PATH"
cat $ANSIBLE_INVENTORY_PATH
echo "-- end"
