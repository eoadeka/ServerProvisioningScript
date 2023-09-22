# Server Provisioning Script

Write a script that automates the setuop of a basic server environment.
This could include installing necessary packages, configuring users, and setting up firewall rules.


Notes:
- Had to reconfigure dpkg in order to install the new packages "openssh-server and ufw". The command was: `sudo dpkg --configure -a`.
- Reconfiguration resulted in the following error:
`dpkg: error: dpkg frontend lock was locked by another process with pid 20485`
Was solved by rebooting ubuntu
