#cloud-iptables-firewall

Firewall script for a cloud instance running Debian, using iptables

Legal note: THIS INFORMATION IS FOR EDUCATIONAL PURPOSES ONLY; I SHALL NOT BE HELD RESPONSIBLE FOR ANY DAMAGES POSSIBLY INCURRED!

Firewalling IPv6 traffic is a concern, either now or in the future when IPv6 becomes available to a VM.

Part of this concern is any IPv6 traffic tunnelled through IPv4 (either by ISATAP or Microsoft's Teredo).

Generally (but I have not tested this), IPv6 traffic protection involves the same commands as IPv4, but given to a different program.

Therefore, this firewall script attempts to work whether or not you have IPv6 (however, untested). If you have IPv6, it will attempt to include it.

##General instructions:

First, make sure you have installed the Debian package, 'iptables':

```bash
$ aptitude install iptables
```

Now you can lock down your system:

```bash
$ /etc/init.d/iptables halt
```

If for any reason (before finishing) you need to access the Internet, just do:

```bash
$ /etc/init.d/iptables clear
```

Make a directory for your firewall scripts:

```bash
$ mkdir /root/firewall
$ cd /root/firewall
```

Download the script and upload it to your VM.

Referring to, 'firewall.sh', customize the file, 'unique.shi'. Then run, reviewing the output for error messages:

```bash
$ /root/firewall/firewall.sh
```

If there are none, then do:

```bash
$ /etc/init.d/iptables save active
$ /root/firewall/minimal.sh
$ /etc/init.d/iptables save inactive
$ /etc/init.d/iptables start
```

To see listening (open) ports:

```bash
$ netstat -ln
```

If or when you receive notice from your VM provider that they have added IPv6 support, or if you add it yourself, then redo the above steps, starting with, 'firewall.sh'.

To keep the desired firewall rules working, automatically after reboot:
Install the package, 'iptables'.

```bash
$ mkdir /var/lib/iptables
```

Run this script.

```bash
$ /etc/init.d/iptables save active
$ ln -si --no-dereference ../init.d/iptables /etc/rcS.d/S40iptables
```

The iptables package & service work in this way:
To clear the firewall (and accept everything):

```bash
$ /etc/init.d/iptables clear
```

To 'Lock-down' (drop everything):
(Emergency halt function, in case of attack):

```bash
$ /etc/init.d/iptables halt
```

Make desired normal running firewall, then:

```bash
$ /etc/init.d/iptables save active
$ /etc/init.d/iptables start
```

Make desired locked down firewall, then:

```bash
$ /etc/init.d/iptables save inactive
$ /etc/init.d/iptables stop
```

##References

Derived from, 'Bastion Host IPTables Script', Appendix A (or chapter 2) of James Turnbull's book, _Hardening Linux_.
To download that script, see www.apress.com.

Blog post: http://markdblackwell.blogspot.com/2011/11/ipv6-aware-cloud-iptables-hand-firewall.html

Copyright (c) 2011 Mark D. Blackwell. See [GPL-LICENSE.txt](GPL-LICENSE.txt) for details.
