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

---
=> Key Based

On the server, check the sftpuser home directory:

sudo mkdir -p /home/sftpuser/.ssh
sudo nano /home/sftpuser/.ssh/authorized_keys


Paste the contents of your local id_

Then set proper permissions:

sudo chown -R sftpuser:sftpusers /home/sftpuser/.ssh
sudo chmod 700 /home/sftpuser/.ssh
sudo chmod 600 /home/sftpuser/.ssh/authorized_keys

```
