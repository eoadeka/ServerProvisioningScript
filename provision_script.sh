#!/bin/bash

# Check if script is run as root or with sudo
if [ "$EUID" -ne 0 ]; then
	echo "Please run this script as root or with sudo"
	exit 1
fi

# Update package list and upgrade existing packages
echo "Upgrading packages..."
apt update && apt upgrade -y

# Install packages (OpenSSH Server and Uncomplicated Firewall (ufw))
echo "Installing packages..."
apt install -y openssh-server ufw
# dpkg --configure -a


# Configure SSH
echo "Configuring SSH..."
echo "Changing port to 2222..."
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sudo systemctl start ssh
sudo systemctl enable ssh
sudo systemctl status ssh

# Configure Users
echo "Creating new user..."
read -p "Enter a username: " username
# using "useradd" because I just want to add a temporary user (name only); I know "adduser" is used to add full profile and info (incl. permissions, passwd)
useradd $username

# Grant sudo privileges to new user
echo "Granting sudo privileges to new user..."
usermod -aG sudo $username

# Setup firewall rules
echo "Setting up firewall rules..."
ufw allow OpenSSH # Allow SSH traffic
ufw enable	  # Enable the firewall
ufw status 	  # Check firewall status

echo "Server setup completed."

# Reboot server
reboot
