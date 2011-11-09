#!/bin/bash

# Author: Mark D. Blackwell
# Dates:
# (mdb) Oct 30, 2011: Create.

# Firewall script for a VM running Debian lenny.
# Tested on Linux kernel 2.6.18.8.

# Usage example:
#   firewall.sh

source ./minimal.sh
source ./ranges.shi

# Specify these IP's regarding the External Interface in the file, 'unique.shi' (see below).
# My external IP
#   ipv4_ext_addr_my="<IP address (ipv4)>"
#   ipv6_ext_addr_my="<IP address (ipv6), if any>"

# Authorized Remote IP's (through the External Interface)
#   ipv4_authorized_remote_ips="<space-separated list of (IPv4) IP addresses>"

if test -f ./unique.shi
then
  source ./unique.shi
else
  echo "Missing file, 'unique.shi'"
  exit
fi

source ./stateless.shi
source ./stateful.shi

# List what's been done (use numeric IP's):
$ipt4 -nv -L
$ipt6 -nv -L

# While debugging, halt afterward.
#/etc/init.d/iptables halt
