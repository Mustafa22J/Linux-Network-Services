# Linux Network Services Infrastructure (SSH + Firewall + DNS)

## Project Summary

This project demonstrates the deployment and validation of core Linux network services in an SBA-style environment.

Implemented services:

- SSH (Password + Public Key authentication)
- Custom firewall policy using iptables
- Netcat service validation on TCP 16389
- Authoritative DNS forward zone using BIND (snappy.lab)

All services were deployed on a clean RHEL 8 installation and validated using structured troubleshooting methods.

---

## Network Topology

Server:
- Primary IP: 172.16.30.33/24
- Alias IP: 172.16.32.33/24

Client:
- IP: 172.16.30.133/24

---

## Services Implemented

### 1️⃣ SSH Hardening
- Password authentication (lab user)
- Public key authentication (someone user)
- Service verification using ss and connection testing

Security validation:
- Forced public-key authentication test
- Verified no-password login functionality

---

### 2️⃣ Firewall Policy (iptables)

Custom INPUT chain policy:

- Allow loopback
- Allow ESTABLISHED/RELATED
- Allow SSH (22)
- Allow TCP 16389 from 172.16.30.0/24
- Reject TCP 16389 from all other sources

Validated using:
- iptables -L
- netcat listener
- Controlled client connection tests

---

### 3️⃣ DNS (BIND)

Authoritative forward zone:
snappy.lab

Zone file:
- SOA
- NS record
- A record for ns1.snappy.lab → 172.16.30.33

Validated using:
dig @172.16.30.33 ns1.snappy.lab

---

## Service Verification Tools

- ss
- iptables
- nc (netcat)
- dig
- nmcli

---

## Skills Demonstrated

- Linux network configuration
- SSH authentication models
- Firewall rule ordering & security logic
- Authoritative DNS deployment
- Service validation methodology
- Structured troubleshooting

Status: Successfully implemented and validated.
