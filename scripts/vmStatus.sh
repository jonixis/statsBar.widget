#!/bin/bash

# Enter your VM name after showvminfo. e.g: Ubuntu 18.04.2 LTS
# Also check location of vboxmanage binary
echo $(/usr/local/bin/VBoxManage showvminfo "Ubuntu 18.04.2 LTS" | grep -c "running (since")
