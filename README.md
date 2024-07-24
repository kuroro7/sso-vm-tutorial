## SSO VM Tutorial


## CentOS 7

Download CentOS 7 from here:
https://centos.org/download/

## Repositories

1 - Add the following content to `/etc/yum.repos.d/CentOS-Base.repo`:

```conf
[base]
name=CentOS-$releasever - Base
baseurl=http://vault.centos.org/7.9.2009/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-$releasever - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-$releasever - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://vault.centos.org/7.9.2009/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.5/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
```

2 - Update repositories:

```sh
yum update -y
```

## Install SSH Server

```sh
# Disable firewall to not be dropped easily
systemctl stop firewalld

# Add time limits on /etc/ssh/sshd.conf
ClientAliveInterval 60 # 60 seconds interval
ClientAliveCountMax 40 # 40 * interval

systemctl restart sshd
```


## Install Dependencies

```sh
# ia32-libs
yum install -y libstdc++.i686 glibc.i686 libgcc.i686

# wget + vim
yum install -y wget vim psmisc
```

## JAVA

```sh
# Download Java JDK 1.7.0 u80 from here:
https://www.oracle.com/br/java/technologies/javase/javase7-archive-downloads.html

# Then install
yum install -y jdk-7u80-linux-x64.rpm
```

## MySQL

```sh
# Install
yum install -y MariaDB-server MariaDB-client

systemctl start mariadb
systemctl enable mariadb

# Then reset the password for mysql
mysql_secure_installation

systemctl restart mariadb
```

Then set max_connections on `/etc/my.cnf`

```sh
[mysqld]
max_connections = 500
```

## Create the database and restore

```sh
# Open mysql console
mysql -u root -p

# Create the database
CREATE DATABASE zx;

# Then restore
mysql -u root -p zx < /zx.sql
```

## Copy libraries

Copy the additional files to the `/etc` folder:

```
authd.conf
gmopgen.xml
GMServer.conf
hosts
iweb.conf
```

Then the following library to `/usr/lib`:

```
libpcre.so.0
```

Then the following libraries to `/usr/lib64`:

```
libpcre.so.0
libskill.so
libtask.so
```

And finaly all custom scripts and SSO ruby basic interface into `/SDServer/`

```
start70gb.sh
gamedb-backup.sh
mysql-backup.sh

# optional
sso-client-scripts/
```

## Copy server files

1 - Put all server files in `/SDServer` folder

2 - Change permissions:

```sh
chmod 644 -R /SDServer
```

3 - Copy .jar dependencies to java folder:

```sh
cp -rv /SDServer/authd/lib/*.jar /usr/java/jdk1.7.0_80/lib/
```

## Install Ruby (Main Server Only)

```sh
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

yum install -y curl

curl -sSL https://get.rvm.io | bash

source /etc/profile.d/rvm.sh

rvm install 3.0.2
```

## SSO Client Scripts (Main Server Only)

```sh
yum install -y mysql-devel gcc make zlib-devel openssl-devel libyaml-devel libffi-devel readline-devel

cd /SDServer/sso-client-scripts

gem install mysql2 -v '0.5.5' -- --with-mysql-config=/usr/bin/mysql_config

bundle install
```

## Edit Cross Server address

On main server, edit the file `/SDServer/gdeliveryd/gamesys.conf`, and in section `[CentralDeliveryClient]`, set the `address` variable to server 2 IP address.

## Install HTOP

```sh
yum install epel-release -y
yum update -y
yum install -y htop
```

## Installing NGINX (Main Server Only)

```sh
# Libs need

yum -y install policycoreutils-python nginx httpd-tools

# Enable for selinux

semanage port -a -t http_port_t -p tcp 9850
setsebool -P httpd_can_network_connect 1
```

Edit default config for nginx on `/etc/nginx/conf.d/default.conf`:

```conf
server {
    listen 9850;
    server_name _;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Autenticação Básica
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
}
```

Then do the final steps:

```sh
htpasswd -c /etc/nginx/.htpasswd root
systemctl enable nginx
systemctl start nginx
```

## Firewall Rules

```sh
# Enable nginx port over basic auth
firewall-cmd --zone=public --add-port=3033/tcp --permanent
# Enable game port
firewall-cmd --zone=public --add-port=29010/tcp --permanent

# Enable cross-server port (SERVER 2 ONLY)
firewall-cmd --zone=public --add-port=49500/tcp --permanent

# Reload rules and restart firewall+nginx
firewall-cmd --reload
systemctl restart firewalld
systemctl restart nginx
```

## SSH Security

First, generate a rsa public key in your own machine:

```sh
# linux
ssh-keygen -t rsa -b 4096
ssh-copy-id [USER]@[SERVER]

# windows
# TODO: Generate key step
```

**If you're using a WINDOWS client, you need to manually copy your public key to your hosts `~/.ssh/authorized_keys`**

Then update `/etc/ssh/sshd_config` file to block password login:

```sh
Port 9851
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin prohibit-password
ChallengeResponseAuthentication no
UsePAM yes
```

Restart SSHD service:

```sh
systemctl restart sshd
```

Update the firewall configuration:

```sh
# Allow the new port
firewall-cmd --permanent --add-port=9851/tcp

# Block the old one
firewall-cmd --permanent --remove-port=22/tcp

# Reload firewall
firewall-cmd --reload
```

## Fail2Ban

Install Fail2Ban:

```sh
yum -y install fail2ban
```

Add configurations to services, editting the file `/etc/fail2ban/jail.local`:

```conf
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1
bantime  = 600
findtime  = 600
maxretry = 5
backend = auto

[sshd]
enabled = true
port = 9851
logpath = /var/log/secure
maxretry = 5
bantime = 600

# Main Server Only
[nginx-http-auth]
enabled = true
port = 9850
logpath = /var/log/nginx/error.log
maxretry = 5
bantime = 600
```

Start the fail2ban service:

```sh
# Starting
systemctl start fail2ban

# Enabling
systemctl enable fail2ban

# Checking status
fail2ban-client status
```

## mpstat

Is a required tool to see hardware status in iweb

```sh
yum install sysstat
systemctl enable sysstat
systemctl start sysstat
```

## Cronjobs

Add these jobs with `crontab -e`:

```sh
# Everyday at 2am
0 2 * * * /SDServer/rankglobaldaily.sh

# Every sunday at 3am
0 3 * * 0 /SDServer/rankglobalweekly.sh

# Everyday at 4am
0 4 * * * /SDServer/rankleaguedaily.sh

# Every sunday at 5am
0 5 * * 1 /SDServer/rankleagueweekly.sh

# Everyday at midnight (MySQL Backup)
0 0 * * * /SDServer/mysql-backup.sh

# Everyday at 1am (GameDB Backup)
0 1 * * * /SDServer/gamedb-backup.sh
```

To check logs from jobs:

```sh
tail -f /var/log/cron
```

## Start the server

```sh
# Only main maps
/SDServer/start.sh

# 64gb settings
/SDServer/start70gb.sh

# Cross Server settings
/SDServer/start16gb.sh
```
