# Bash-Assignment

### SFTP

```
sudo apt update
sudo apt install openssh-server -y
sudo systemctl status ssh
sudo groupadd sftpusers
sudo useradd -m sftpuser -s /usr/sbin/nologin -g sftpusers
sudo passwd sftpuser
sudo mkdir -p /data/sftp/uploads

sudo chown root:root /data/sftp
sudo chmod 755 /data/sftp

sudo chown sftpuser:sftpusers /data/sftp/uploads

sudo nano /etc/ssh/sshd_config

Add the following block at the bottom:

pgsql
Copy
Edit
Match Group sftpusers
    ChrootDirectory /data/sftp
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no

sudo systemctl restart ssh

sudo nano /etc/ssh/sshd_config (50.,60.)

PasswordAuthentication yes
PermitRootLogin no
UsePAM yes

```
