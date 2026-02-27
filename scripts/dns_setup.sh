#!/bin/bash

# DNS Installation Helper Script
# Author: Mustafa Jawish

echo "Installing BIND..."
dnf install -y bind bind-utils

echo "Enable and start named service..."
systemctl enable --now named

echo "Check if DNS is listening..."
ss -tlnp | grep :53

echo "DNS setup complete."
