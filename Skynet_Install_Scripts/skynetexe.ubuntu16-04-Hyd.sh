#!/bin/sh
# Created by: Shoeb Shaikh

echo Getting new machine ready for Skynet ExE > /skynetexe-setup.log
echo Starting skynetexe.sh >> /skynetexe-setup.log

# Update sources.list 
echo Updating sources.list >> /postinstall.log
echo "deb http://hydlnxpkg.amd.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://hydlnxpkg.amd.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://hydlnxpkg.amd.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://hydlnxpkg.amd.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
apt-get update
#apt-get dist-upgrade

# Install smbclient, cifs-utils, openssh-server
echo Install build-essential, smbclient, cifs-utils, openssh-server >> /skynetexe-setup.log
apt-get -y install build-essential
apt-get -y install smbclient
apt-get -y install cifs-utils
apt-get -y install openssh-server

echo Create and add taccuser to system >> /skynetexe-setup.log
username="taccuser"
egrep $username /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "$username exists!"
else
	pass="paTorfUIoep3A"
	useradd -m -p $pass $username
	[ $? -eq 0 ] && echo "$username has been added to system!" || echo "Failed to add a $username!"
fi

# Setup taccuser to auto login
echo Adding taccuser as autologin user >> /skynetexe-setup.log
echo "[Seat:*]" >> /etc/lightdm/lightdm.conf
echo "autologin-guest=false" >> /etc/lightdm/lightdm.conf
echo "autologin-user=taccuser" >> /etc/lightdm/lightdm.conf
echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf


#Disable update automatically
echo Disable update autoamtically >> /skynetexe-setup.log
echo "APT::Periodic::Unattended-Upgrade \"0\";" >> /etc/apt/apt.conf.d/10periodic

#Download and setup executor
echo Download and setup executor >> /skynetexe-setup.log
EXEARCHIVE=skynetexe_executor_hostdriven_lnx.tar.gz

if [`uname -m`=="x86_64"]; then
	EXEARCHIVE=skynetexe_executor_hostdriven_lnx64.tar.gz
fi
if [ `uname -m`=="x86_64" ]; then
	EXEARCHIVE=skynetexe_executor_hostdriven_lnx64.tar.gz
fi

wget http://hydlnxpkg.amd.com/skynet_exec_lnx_rel/$EXEARCHIVE

mkdir /usr/local/bin
chown taccuser:taccuser /usr/local/bin

pgrep "startexe" 2>&1 > /dev/null
if [ $? -eq 0 ]
then
{
	echo "startexe is running. Killing."
	ps -ef | grep "startexe" | grep -v grep | awk '{print $2}' | xargs kill -9
}
else
{
	echo "startexe is not running"
}; fi

if [ -d /usr/local/bin/Executor ]; then
	rm -rf /usr/local/bin/Executor
fi

tar -xzf $EXEARCHIVE -C /usr/local/bin
chown taccuser:taccuser /usr/local/bin/*

#set autostart
echo Inserting Skynet ExE in startup >> /skynetexe-setup.log
cat <<EOF >> /etc/xdg/autostart/SkynetExe.desktop
[Desktop Entry]
Name=SkynetExe Client
Type=Application
Exec=gnome-terminal --working-directory=/usr/local/bin/Executor -e ./startexe
StartupNotify=false
X-GNOME-Autostart-delay=10
EOF

#Turn off screen blanking
echo Turn off blank screen and screen saver with gsettings >> /skynetexe-setup.log
cat <<EOF > /usr/bin/disableBSSS.sh
gsettings set org.gnome.desktop.screensaver lock-enabled  false
gsettings set org.gnome.desktop.session idle-delay 0
EOF

#Create testresdirectory and change permissions
echo Create testres, hd-media and TACCDrv and change permissions >> /skynetexe-setup.log
mkdir /testres
mkdir /hd-media
mkdir /TACCDrv
chown taccuser:taccuser /testres
chown taccuser:taccuser /hd-media
chown taccuser:taccuser /TACCDrv
chmod 777 /testres
chmod 777 /hd-media
chmod 777 /TACCDrv

# Add user to sudoers
echo adding taccuser to sudoers list >> /skynetexe-setup.log
echo "taccuser ALL=(ALL) ALL" >> /etc/sudoers
echo adding taccuser to start sudo programs without using password >> /skynetexe-setup.log
echo "taccuser ALL=NOPASSWD: ALL" >> /etc/sudoers
echo Exiting skynetexe.sh >> /skynetexe-setup.log
reboot