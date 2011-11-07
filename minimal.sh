#!/bin/bash

# Minimal firewall
# Usage example:
#   minimal.sh

# Normally, this file is sourced. Therefore, do not use, 'exit'.

# Distinguish from other Debian scripts (if run at boot):
echo "Running $0..."

# VARIABLES
# Interfaces
loopback_interf="lo"
ext_interf="eth0" # External Interface

# Location of the binaries - Change these to match your environment.
sysctl4="/sbin/sysctl"
ipt4="/sbin/iptables"

# My VM can't do modprobe, but it has no IPv6, per command, 'ip6tables -L'.

# Check for IPv6:
check_for_ipv6="test -f /proc/net/if_inet6"
check_for_modprobe="modprobe ipv6"
echo "Testing for IPv6."
if $check_for_ipv6
then
  echo "$check_for_ipv6 worked--but IPv6 firewall untested."
  sysctl6="/sbin/sysctl"
  if $check_for_modprobe 2> /dev/null
  then
    echo "'$check_for_modprobe' worked--but IPv6 firewall untested."
    ipt6="/sbin/ip6tables"
  else
    echo "'$check_for_modprobe' failed--not filtering Ipv6 packets."
    ipt6=":" # Do nothing.
  fi
else
  echo "'$check_for_ipv6' failed--okay; an Ipv6 firewall is unnecessary."
  sysctl6=":"
  ipt6=":"
fi

source ./kernel_parameters.shi

# Flush all Rules
$ipt4 -F
$ipt6 -F

#Set Policies
# Note: REJECT is an invalid policy (though elsewhere is a valid jump action).
$ipt4 -P INPUT DROP
$ipt6 -P INPUT DROP

$ipt4 -P OUTPUT DROP
$ipt6 -P OUTPUT DROP

$ipt4 -P FORWARD DROP
$ipt6 -P FORWARD DROP

# Delete all User-created Chains
$ipt4 -X
$ipt6 -X
