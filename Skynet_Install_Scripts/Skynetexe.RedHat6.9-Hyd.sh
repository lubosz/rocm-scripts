echo Starting Post Install > /postinstall.log

######### Setup package repository #########
echo Setting up package repository >> /postinstall.log
wget -P /etc/yum.repos.d/ http://hydlnxpkg.amd.com/dist/redhat/rhel-6.9/workstation/x86_64/rhel-base.repo

######### Root login #########
# Allow root to log into GUI by commenting out the following lines
sed -i 's|\(^.* pam_succeed_if.so user != root quiet.*$\)|#\1|' /etc/pam.d/gdm-autologin
sed -i 's|\(^.* pam_succeed_if.so user != root quiet.*$\)|#\1|' /etc/pam.d/xdm

# Suppress warning popup about root logging in
sed -i 's|\(^.*schema=".*show_root_warning".*$\)|<!-- \1 -->|g' /etc/gconf/gconf.xml.defaults/%gconf-tree.xml

# Create taccuser
echo Create taccuser >> /postinstall.log
sudo useradd -m -p paTorfUIoep3A taccuser

# Add user to sudoers
echo adding taccuser to sudoers list >> /postinstall.log
echo "taccuser ALL=(ALL) ALL" >> /etc/sudoers
echo adding taccuser to start sudo programs without using password >> /postinstall.log
echo "taccuser ALL=NOPASSWD: ALL" >> /etc/sudoers

# Update the GDM custom.conf file to autologin the taccuser user (GUI MODE)
echo Updating GDM custom.conf file to autologin the taccuser user >> /postinstall.log
cp /etc/gdm/custom.conf /etc/gdm/custom.conf.orig
echo "[daemon]" > /etc/gdm/custom.conf
echo "AutomaticLoginEnable=true" >> /etc/gdm/custom.conf
echo "AutomaticLogin=taccuser" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[security]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[xdmcp]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[gui]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[greeter]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[chooser]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[debug]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf
echo "[servers]" >> /etc/gdm/custom.conf
echo " " >> /etc/gdm/custom.conf

# Disable screensaver and screen blanking:
echo Disabling screensave and screen blanking >> /postinstall.log
echo "gconftool-2 --type boolean -s /apps/gnome_settings_daemon/screensave/start_screensaver false" >> /etc/profile
echo "setterm -blank 0 -powersave off" >> /etc/profile
wget http://hydlnxpkg.amd.com/dist/redhat/rhel-6.9/workstation/x86_64/gconf.tgz
tar -zxf gconf.tgz


#Turn off screen blanking
echo Turn off blank screen and screen saver with gsettings >> /postinstall.log
cat <<EOF > /usr/bin/disableBSSS.sh
gconftool-2 --type bool --set /apps/gnome-screensaver/idle_activation_enabled false
gconftool-2 --type bool --set /apps/gnome-screensaver/lock_enabled false
gconftool-2 --type boolean -s /apps/gnome_settings_daemon/screensave/start_screensaver false
setterm -blank 0
xset s off s noblank -dpms
EOF

chmod +x /usr/bin/disableBSSS.sh
cat <<EOF > /etc/xdg/autostart/disableBSSS.desktop
[Desktop Entry]
Type=Application
Name=DISABLEBSSS
Exec=/usr/bin/disableBSSS.sh --launch-immediately
NoDisplay=false
X-GNOME=AutoRestart=true
X-GNOME=Autostart-Phase=Initialization
EOF

# Get the EST tarbal
echo Getting the EST tarbal >> /postinstall.log
cd /
wget http://hydlnxpkg.amd.com/dist/linuxest.tar.gz
tar zxvf linuxest.tar.gz

# Install SkynetExE
echo Installing SkynetExE >> /postinstall.log
EXEARCHIVE=skynetexe_executor_hostdriven_lnx_mono-2.11.tar.gz
if [ `uname -m` == "x86_64" ]; then
	EXEARCHIVE=skynetexe_executor_hostdriven_lnx64_mono-2.11.tar.gz
fi
wget http://hydlnxpkg.amd.com/skynet_exec_lnx_rel/$EXEARCHIVE
tar -xzf $EXEARCHIVE -C /usr/local/bin
chown taccuser:taccuser /usr/local/bin/

# Set SkynetExE to autostart
cat <<EOF >> /etc/xdg/autostart/SkynetExe.desktop
[Desktop Entry]
Name=SkynetExe Client
Type=Application
Exec=gnome-terminal --working-directory=/usr/local/bin/Executor -e ./startexe
StartupNotify=false
X-GNOME-Autostart-delay=10
EOF

#Create testres, hd-media and TACCDrv and change permissions
echo Create testres, hd-media and TACCDrv and change permissions >> /postinstall.log
mkdir /testres
mkdir /hd-media
mkdir /TACCDrv
chown taccuser:taccuser /testres
chown taccuser:taccuser /hd-media
chown taccuser:taccuser /TACCDrv
chmod 777 /testres
chmod 777 /hd-media
chmod 777 /TACCDrv

SUT="None"

#check kernel command line for SUT
if [ "$SUT" == "None" ]; then
	echo Checking for SUT in /proc/cmdline >> /postinstall.log
	if [ -e '/proc/cmdline' ]; then
		echo File /proc/cmdline FOUND >> /postinstall.log
		# Check for SUT in cmdline
		cat /proc/cmdline | grep -q SUT=
		if [ $? == 0 ]; then
			SUT=$(cat /proc/cmdline|sed 's/\s/\n/g'|grep SUT=|cut -d= -f2)
			echo SUT="$SUT" FOUND >> /postinstall.log
		else
			echo SUT NOT FOUND >> /postinstall.log
		fi
	else
		echo File /proc/cmdline NOT FOUND >> /postinstall.log
	fi
fi

echo Changing the permissions on the files/folders of usr local bin. >> /postinstall.log
chmod -Rf 777 /usr/local/bin/

# Determine BIOS Mode 
echo Determining BIOS Mode >> /postinstall.log
if [ -d /sys/firmware/efi ]; then
	echo BIOS Mode: EFI >> /postinstall.log
	echo Setting EFI Network Boot Device 1st in Boot order >> /postinstall.log
	efibootmgr -o 2003
else
	echo BIOS Mode: LEGACY >> /postinstall.log
fi

# Add script to set EFI Boot Sequence when system boots up
echo Adding set EFI boot order to rc.local so it runs on bootup >> /postinstall.log
cat <<EOF >> /etc/rc.d/rc.local
# Fix Boot order on startup
echo Fixing EFI Boot Order > /fix_efiboot.log
if [ -d /sys/firmware/efi ]; then
	echo BIOS Mode: EFI >> /fix_efiboot.log
	echo Setting EFI Network Boot Device 1st in Boot order >> /fix_efiboot.log
	efibootmgr -o 2003
else
	echo BIOS Mode: LEGACY >> /fix_efiboot.log
fi
EOF
chmod +x /etc/rc.d/rc.local

mkdir -p /home/taccuser/.local/share/keyrings
cat <<EOF >> /home/taccuser/.local/share/keyrings/login.keyring
[keyring]
display-name=login
ctime=0
mtime=0
lock-on-idle=false
lock-after=false
EOF
chown -R taccuser:taccuser /home/taccuser/.local

# Change hostname (RHEL 6)
echo Changing Hostname >> /postinstall.log
echo "NETWORKING=yes" > /etc/sysconfig/network
echo "HOSTNAME=$SUT" >> /etc/sysconfig/network
echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
echo "IPV6INIT=no" >> /etc/sysconfig/network
echo "Exiting Post Install" >> /postinstall.log
echo ********** Rebooting Now **********************
sudo reboot
%end
