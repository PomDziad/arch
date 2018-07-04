#pacman
pacman -Sy &&

#Czas
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && hwclock --systohc &&

#Język
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen &&
echo "LANG=pl_PL.UTF-8" > /etc/locale.conf &&

#Nazwa kompa
echo "ArchLinux" > /etc/hostname &&

#bootloader (grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB dla EFI)
pacman -S --noconfirm grub &&
grub-install --target=i386-pc /dev/sda &&
grub-mkconfig -o /boot/grub/grub.cfg &&

#podstawy środowiska
pacman -S --noconfirm xorg ttf-dejavu sudo dialog &&

#Hasło admina
echo "Wpisz hasło dla konta root"
passwd &&

#pytanie o sterowniki
echo " WYBIERZ STEROWNIK (domyślnie=1): 1)vesa  2)nvidia  3)intel  4)amd "
read sterownik
case $sterownik in
"1") pacman -S --noconfirm xf86-video-vesa ;;
"2") pacman -S --noconfirm xf86-video-nouveau ;;
"3") pacman -S --noconfirm xf86-video-intel ;;
"4") pacman -S --noconfirm xf86-video-amdgpu ;;
*) pacman -S --noconfirm xf86-video-vesa ;;
esac

#pytanie o środowisko
echo " WYBIERZ ŚRODOWISKO GRAFICZNE(domyślnie=1):
 1) LXDE
 2) Xfce
 3) MATE
 4) GNOME (niedodane)
 5) Plasma (niedodane)
 6) Cinnamon (niedodane) "
read desktop
case $desktop in
"1") pacman -S --noconfirm lightdm lightdm-gtk-greeter lxde &&
 echo "kopiowanie configu lightdm" && 
 echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm ;;
"2")  pacman -S --noconfirm lightdm lightdm-gtk-greeter xfce4 xfce4-goodies &&
 echo "kopiowanie configu lightdm" && 
 echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm ;;
"3")  pacman -S --noconfirm lightdm lightdm-gtk-greeter mate mate-extra &&
 echo "kopiowanie configu lightdm" && 
 echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm ;;
"4") echo "nic" ;;
"5") echo "nic" ;;
"6") echo "nic" ;;
*) pacman -S --noconfirm lightdm lightdm-gtk-greeter lxde &&
 echo "kopiowanie configu lightdm" && 
 echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm ;;

#dodawanie użytkownika (sudo ręcznie)
echo "Wpisz nazwę użytkownika do stworzenia (małe litery): "
read user
useradd --create-home $user &&
passwd $user &&

#włączanie lightdm
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm && echo "Teraz zresetuj"

