#!/bin/bash

# Minimal firewall
# Usage example:
#   minimal.sh

# Often, this file is sourced. Therefore, do not use, 'exit'.

# Location of the binaries - Change these to match your environment.
sysctl4="/sbin/sysctl"
ipt4="/sbin/iptables"

# My VM can't do modprobe, but anyway it has no IPv6, per command, 'ip6tables -L'.

# Check for IPv6:
check_no_IPv6="test ! -f /proc/net/if_inet6"
check_for_modprobe="modprobe ipv6"
echo "Testing for IPv6."
if $check_no_IPv6
then
  echo "'$check_no_IPv6' worked--okay; an Ipv6 firewall is unnecessary."
  sysctl6=":" # Do nothing.
  ipt6=":"
else
  echo "$check_no_IPv6 says may see IPv6 packets."
  sysctl6=$sysctl4
  if ! $check_for_modprobe 2> /dev/null
  then
    echo "WARNING: '$check_for_modprobe' failed--unable to filter (any) Ipv6 packets."
    ipt6=":"
  else
    echo "WARNING: '$check_for_modprobe' worked--but IPv6 firewall untested."
    ipt6="/sbin/ip6tables"
  fi
fi

# Interfaces
loopback_interf="lo"
ext_interf="eth0" # External Interface

# Allow traffic after halt
/etc/init.d/iptables clear

# Set kernel parameters
source ./kernel_parameters_ipv4.shi
source ./kernel_parameters_ipv6.shi

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
