#!/bin/bash
read -p "User: " Username

mkdir /var/www/html/$Username && mkdir /var/www/html/$Username/public && echo "Direcotrios publicos creados"
useradd -d /var/www/html/$Username/public -G sftponly,mail -s /bin/false $Username && echo "Usuario creado"
touch /var/www/html/$Username/public/index.html && echo "Works!" > /var/www/html/$Username/public/index.html && echo "Fichero de prueba creado"
mkdir /var/www/html/$Username/Mail
chown -R $Username:$Username /var/www/html/$Username
passwd $Username

read -p "Usar IPFS: " optionIPFS
if [ $optionIPFS == "y" ]
then
	ipfsHash=$( ipfs add -r /var/www/html/$Username/public | grep "public" | tail -n1 | awk  '{print $2}' )
	ipfs key gen --type=rsa --size=2048 $Username && echo "Clave IPNS creada"
	echo "Subiendo a IPFS y creando IPNS..."
	touch $Username"_NewUser.txt"
	echo "Usuario:"$Username >> $Username"_NewUser.txt"
	echo "IPNS:"${Ipnshash%?} >> $Username"_NewUser.txt"
	ipfs name publish --key=$Username $ipfsHash | awk '{print $3}' >> $Username"_NewUser.txt" &
fi

#echo "tor"
#echo "HiddenServiceDir /var/lib/tor/$Username/" >> /etc/tor/torrc
#echo "HiddenServicePort 80 0.0.0.0:80" >> /etc/tor/torrc 
#systemctl reload tor
#sleep 5
#cat /var/lib/tor/$Username/hostname
#printf "server {\n    listen 80;\n    server_name $(cat /var/lib/tor/$Username/hostname) ;\n    root /var/www/html/$Username/public;\n    index index.html index.htm index.php;\n}" >> /etc/nginx/sites-available/wildcard.conf
#systemctl reload nginx
