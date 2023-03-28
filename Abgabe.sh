#!/bin/bash
read -p 'Matrikelnummer: ' matrnr
tar -zcvf "$matrnr.tar.gz" Lösungen
echo "Stelle Abgabe bereit.... Bitte warten..."
sudo apt-get update > /dev/null
sudo apt-get install nfs-kernel-server > /dev/null
sudo mkdir /var/nfs/abgabe -p
sudo chown mirouser:mirouser /var/nfs/abgabe > /dev/null
sudo echo "/var/nfs/abgabe *(ro,sync,no_subtree_check)" > /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
abgabenummer=$(ip -4 addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
echo
sudo cp $matrnr.tar.gz /var/nfs/abgabe/
echo Abgabe abgeschlossen. Ihre Abgabenummer ist: ${abgabenummer:7}
echo Schließen Sie die VM nicht, bis Ihre Abgabe eingesammelt wurde!