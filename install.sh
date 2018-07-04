#!/bin/bash
#Czcionka
setfont Lat2-Terminus16.psfu.gz -m 8859-2 &&

#Zgoda
echo "[UWAGA]
NAJPIERW TRZEBA PRZYGOTOWAĆ I ZAMONTOWAĆ PARTYCJE! 
Wpisz 'tak', jeżeli są zrobione i ZAMONTOWANE."
read zgoda
case $zgoda in
"tak") 

#Instalacja podstawy
pacstrap /mnt base base-devel &&

#FSTAB
genfstab -U /mnt >> /mnt/etc/fstab &&

#chrootowanie
wget raw.githubusercontent.com/PomDziad/arch/master/installd.sh && cp installd.sh /mnt/installd.sh && arch-chroot /mnt bash installd.sh &&
rm install.sh ;;
esac
