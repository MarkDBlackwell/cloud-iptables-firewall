#cloud-iptables-firewall

Firewall script for a cloud instance running Debian Linux, using iptables.

Legal note: THIS INFORMATION IS FOR EDUCATIONAL PURPOSES ONLY; I SHALL NOT BE HELD RESPONSIBLE FOR ANY DAMAGES POSSIBLY INCURRED!

Firewalling IPv6 traffic is a concern, either now or in the future when IPv6 becomes available to a VM. Part of this concern is any IPv6 traffic tunnelled through IPv4 (either by ISATAP or by Microsoft's Teredo).

Generally (but I have not tested this), IPv6 traffic protection involves the same commands as IPv4, but given to a different program. Therefore, this firewall script attempts to work whether or not you have IPv6 (however, this is untested). If you have IPv6, it will attempt to include it.

##Requirements:

First, make sure you have installed the Debian package, 'iptables':

```bash
$ aptitude install iptables
```

Now you can lock down your system, by:<br />
Drop everything (all packets; or emergency halt function, in case of attack):

```bash
$ /etc/init.d/iptables halt
```

If for any reason (before finishing) you need to access the Internet, just:<br />
Clear the firewall (and accept everything):

```bash
$ /etc/init.d/iptables clear
```

Create the directory used (by iptables) for rule sets. (This may not exist, in order to discourage using iptables as a service: see /etc/default/iptables.):

```bash
$ mkdir /var/lib/iptables
```

To automatically at boot start the iptables firewall service (reloading the last saved, 'active' rule set):

```bash
$ ln -si --no-dereference ../init.d/iptables /etc/rcS.d/S40iptables
```

##Installation

Make a directory for your firewall scripts:

```bash
$ mkdir /root/firewall
$ cd /root/firewall
```

As root, download the script and upload it to your VM. Referring to, 'firewall.sh', customize the file, 'unique.shi'. Then, reviewing the output for error messages:

```bash
$ chmod u+x `find . -name '*.sh*'`
$ /root/firewall/firewall.sh
```

If there are none, then save and invoke the normal (running) firewall:

```bash
$ /etc/init.d/iptables save active
$ /etc/init.d/iptables start
```

To make, save and invoke a locked-down firewall:

```bash
$ /root/firewall/minimal.sh
$ /etc/init.d/iptables save inactive
$ /etc/init.d/iptables stop
```

##Other

To see all listening (open) ports at any time:

```bash
$ netstat -ln
```

If (or when) you receive notice from your VM provider that they have added IPv6 support, or if you add it yourself, then redo the above steps, starting with, 'firewall.sh'.

##References

Derived from, 'Bastion Host IPTables Script', Appendix A (or chapter 2) of James Turnbull's book, _Hardening Linux_.
To download that script, see www.apress.com.

Blog post: http://markdblackwell.blogspot.com/2011/11/ipv6-aware-cloud-iptables-hand-firewall.html

Copyright (c) 2011 Mark D. Blackwell. See [GPL-LICENSE.txt](GPL-LICENSE.txt) for details.
