#!/bin/bash

	#affecter le nouveau  nom machine

read -p 'Rentrer le nom du raspberry:  ' name
hostname $name
cp /media/pi/USB/hosts /etc/hosts
echo 127.0.0.1	$name.domaine.localfr	$name >> /etc/hosts
rm /etc/hostname
echo $name >> /etc/hostname

	#ajout des packages pour integration au domaine

apt install -y samba smbclient krb5-config krb5-user krb5-clients winbind libnss-winbind libpam-winbind ntp

	#application des fichiers de conf

echo session required pam_mkhomedir.so skel=/etc/skel/ umask=0022 >> /etc/pam.d/sshd 
echo static domain_name_servers=NomServeurAD >> /etc/dhcpcd.conf
cp /media/pi/USB/krb5.conf /etc/krb5.conf
cp /media/pi/USB/smb.conf /etc/samba/smb.conf
cp /media/pi/USB/nsswitch.conf /etc/nsswitch.conf
cp /media/pi/USB/ntp.conf /etc/ntp.conf

