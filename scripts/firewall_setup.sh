#!/bin/bash

# Firewall configuration script
# Author: Mustafa Jawish

echo "Flushing existing rules..."
iptables -F
iptables -X

echo "Applying base policies..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

echo "Allowing SSH..."
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

echo "Allowing TCP 16389 from 172.16.30.0/24..."
iptables -A INPUT -p tcp -s 172.16.30.0/24 --dport 16389 -j ACCEPT

echo "Rejecting all other access to TCP 16389..."
iptables -A INPUT -p tcp --dport 16389 -j REJECT

echo "Firewall configuration applied."
iptables -L -n --line-numbers
