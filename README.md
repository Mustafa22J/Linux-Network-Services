# Linux Network Services (SSH + Firewall + DNS)

## Overview
This project demonstrates Linux server administration including:

- SSH (Password + Public Key authentication)
- Firewall configuration using iptables
- Netcat validation on TCP 16389
- Authoritative DNS using BIND (snappy.lab)

Server IP: 172.16.30.33
Alias IP: 172.16.32.33
Client IP: 172.16.30.133

---

## Network Configuration

### Server
nmcli con mod ens34 ipv4.method manual
nmcli con mod ens34 ipv4.addresses 172.16.30.33/24
nmcli con mod ens34 +ipv4.addresses 172.16.32.33/24
nmcli con mod ens34 connection.autoconnect yes
nmcli con up ens34

### Client
nmcli con mod ens34 ipv4.method manual
nmcli con mod ens34 ipv4.addresses 172.16.30.133/24
nmcli con mod ens34 connection.autoconnect yes
nmcli con up ens34

---

## Users

useradd lab
passwd lab

useradd someone
passwd someone

---

## SSH Configuration

systemctl enable --now sshd
ss -tlnp | grep :22

Password test:
ssh lab@172.16.30.33

Public key setup:
ssh-keygen -t ed25519
ssh-copy-id someone@172.16.30.33

Public key only test:
ssh -o PreferredAuthentications=publickey -o PasswordAuthentication=no someone@172.16.30.33

---

## Firewall + Netcat (Port 16389)

iptables -F
iptables -X

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.30.0/24 --dport 16389 -j ACCEPT
iptables -A INPUT -p tcp --dport 16389 -j REJECT

iptables -L -n --line-numbers

Server:
nc -vl 172.16.30.33 16389

Client:
nc -v 172.16.30.33 16389

---

## DNS (BIND)

dnf install -y bind bind-utils

named.conf addition:

zone "snappy.lab" IN {
    type master;
    file "snappy.lab.zone";
};

Zone file: /var/named/snappy.lab.zone

$TTL 86400
@   IN  SOA ns1.snappy.lab. root.snappy.lab. (
        2026010101
        3600
        1800
        604800
        86400 )

        IN  NS      ns1.snappy.lab.
ns1     IN  A       172.16.30.33

Permissions:
chown root:named /var/named/snappy.lab.zone
chmod 640 /var/named/snappy.lab.zone

systemctl enable --now named
ss -tlnp | grep :53

Verification:
dig @172.16.30.33 ns1.snappy.lab

---

## Skills Demonstrated

- Linux networking (nmcli)
- SSH hardening (password vs public key)
- Firewall rule ordering (iptables)
- Service validation (ss, nc, dig)
- Authoritative DNS zone deployment (BIND)
- Structured troubleshooting methodology

Status: Completed successfully
