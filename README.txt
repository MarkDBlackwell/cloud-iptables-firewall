# Author: Mark D. Blackwell
# Dates:
# (mdb) Oct 30, 2011: Create.

# Derived from, 'Bastion Host IPTables Script', Appendix A (or chapter 2) of James Turnbull's book, _Hardening Linux_.
# To download that script, see www.apress.com.

# To keep the desired firewall rules working, automatically after reboot:
# Install the package, 'iptables'.
# $ mkdir /var/lib/iptables
# Run this script.
# $ /etc/init.d/iptables save active
# $ ln -si --no-dereference ../init.d/iptables /etc/rcS.d/S40iptables

# The iptables package & service work in this way:
# To clear the firewall (and accept everything):
# $ /etc/init.d/iptables clear

# To 'Lock-down' (drop everything):
# (Emergency halt function, in case of attack):
# $ /etc/init.d/iptables halt

# Make desired normal running firewall, then:
# $ /etc/init.d/iptables save active
# $ /etc/init.d/iptables start

# Make desired locked down firewall, then:
# $ /etc/init.d/iptables save inactive
# $ /etc/init.d/iptables stop
