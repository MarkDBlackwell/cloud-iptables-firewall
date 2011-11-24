#!/bin/bash

# firewall.sh - firewall script for a VM running Debian lenny

# Copyright (C) 2011 Mark D. Blackwell

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Contact me at https://github.com/MarkDBlackwell/

# Author: Mark D. Blackwell
# Dates:
# (mdb) Oct 30, 2011: Create.

# Tested on Linux kernel 2.6.18.8.

# Usage example:
#   firewall.sh

echo "firewall.sh  Copyright (C) 2011 Mark D. Blackwell"
echo "This program comes with ABSOLUTELY NO WARRANTY."
echo "This is free software, and you are welcome to redistribute it"
echo "under certain conditions; see GPL-LICENSE.txt for details."

source ./minimal.sh
source ./ranges.shi

if test ! -f ./unique.shi
then
  echo "The user must create the file, 'unique.shi', and in it"
  echo "specify these IP's regarding the External Interface:"
  echo "My external IP:"
  echo "  ipv4_ext_addr_my=\"<IP address (ipv4)>\""
  echo "  ipv6_ext_addr_my=\"<IP address (ipv6), if any>\""
  echo "Authorized Remote IP's (through the External Interface):"
  echo "  ipv4_authorized_remote_ips=\"<space-separated list of (IPv4) IP addresses>\""
  echo "DNS Server IP:"
  echo "  dns_server=\"<IP address (ipv4)>\""
  exit
fi
source ./unique.shi

source ./stateless.shi
source ./stateful.shi

# List what has been done (use numeric IP's):
$ipt4 -nv -L
$ipt6 -nv -L

# While debugging, halt afterward.
#/etc/init.d/iptables halt
