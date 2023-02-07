# Настройка Bash

## Настройка приглашения командной строки
```sh
# ~/.bashrc

initializeANSI()
{
    esc="\033"  # Если эта последовательность не сработает, но необходимо использовать символ ESC непосредственно
    
    # Цвет шрифта
    blackf="${esc}[30m";    redf="${esc}31m";   greenf="${esc}[32m"
    yellowf="${esc}[33m";   bluef="${esc}[34m"; purplef="${esc}[35m"
    cyanf="${esc}[36m";     whitef="${esc}[37m"
    
    # Цвет фона
    blackb="${esc}[40m";    redb="${esc}[41m";      greenb="${esc}[42m"
    yellowb="${esc}[43m";   blueb="${esc}[44m";     purpleb="${esc}[45m"
    cyanb="${esc}[46m";     whiteb="${esc}[47m"
    
    # Жирный, наклонный, с подчеркиванием и инверсное отображение
    boldon="${esc}[1m";     boldoff="${esc}[22m"
    italicson="${esc}[3m";  italicsoff="${esc}[23m"
    ulon="${esc}[4m";       uloff="${esc}[24m"
    invon="${esc}[7m";      invoff="${esc}[27m"
    
    reset="${esc}[0m"
}
```
```
### Приглашение командной строки обычного пользователя
PS1="${debian_chroot:+($debian_chroot)}\[\033[0;36m\]\A \[\033[0;36m\]<\[\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;33m\]\H\[\033[0;36m\]:\w\[\033[0;36m\]>\[\033[0;32m\] $ \[\033[0m\]"
export PS1

### Приглашение командной строки суперпользователя
PS1="${debian_chroot:+($debian_chroot)}\[\033[0;36m\]\A \[\033[0;36m\]<\[\033[0;31m\]\u\[\033[0;36m\]@\[\033[0;33m\]\H\[\033[0;36m\]:\w\[\033[0;36m\]>\[\033[0;31m\] # \[\033[0m\]"
export PS1


# Файлы профиля нового пользователя по умолчанию на ходятся в каталоге /etc/skel
```
```
# Настройка истории команд
export HISTSIZE=10000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
PROMPT_COMMAND='history -a'
```

```
# Debian

# Обычный пользоваетель
### Приглашение командной строки ###
PS1="${debian_chroot:+($debian_chroot)}\[\033[0;36m\]\A \[\033[0;36m\]<\[\033[0;32m\]\u\[\033[0;36m\]@\[\033[0;33m\]\H\[\033[0;36m\]:\w\[\033[0;36m\]>\[\033[0;32m\] $ \[\033[0m\]"
export PS1


# Суперпользователь
### Приглашение командной строки ###
PS1="${debian_chroot:+($debian_chroot)}\[\033[0;36m\]\A \[\033[0;36m\]<\[\033[0;31m\]\u\[\033[0;36m\]@\[\033[0;33m\]\H\[\033[0;36m\]:\w\[\033[0;36m\]>\[\033[0;31m\] # \[\033[0m\]"
export PS1
```

## nano Установка табуляции в 4 пробела (вместо 8-ми по умолчанию)
```sh
# файл ~/.nanorc
set tabsize 4
set tabstospaces
```

```
apt-get update && apt-get upgrade -y

apt-get install -y \
curl \
exa \
fonts-ubuntu \
htop \
lm-sensors \
mc \
remmina \
screenfetch \
tmux tmux-themepack-jimeh \
tree \
vlc
```

### Установка шрифтов ubuntu в debian
```
# В репо добавить non-free
# apt install fonts-ubuntu
```

```
ss -lntp
```
### LXC on deb10
```

apt install lxc libvirt0 libpam-cgfs bridge-utils

# По умолчанию сеть не настроена
#
#
# Список шаблонов
# ls /usr/share/lxc/templates

# Изменить файл /etc/lxc/default.conf
# lxc.net.0.type = veth
# lxc.net.0.link = virbr0
# lxc.net.0.flags = up
# lxc.apparmor.profile = generated
# lxc.apparmor.allow_nesting = 1
```

### Create MikroTik CHR on Proxmox
```sh


#!/usr/bin/env bash                                                                                                                                                                                                                           
                                                                                                                                                                                                                                              
#vars                                                                                                                                                                                                                                         
version="nil"                                                                                                                                                                                                                                 
vmID="nil"                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                              

echo "############## Start of Script ##############
                                                
## Checking if temp dir is available..."            
if [ -d /root/temp ]                             
then                                              
    echo "-- Directory exists!"                   
else                                                          
    echo "-- Creating temp dir!"
    mkdir /root/temp                        
fi                                                                
# Ask user for version
echo "## Preparing for image download and VM creation!"    
read -p "Please input CHR version to deploy (6.38.2, 6.40.1, etc):" version
# Check if image is available and download if needed
if [ -f /root/temp/chr-$version.img ]               
then                                                 
    echo "-- CHR image is available."                 
else                                                
    echo "-- Downloading CHR $version image file."
    cd  /root/temp                                     
    echo "---------------------------------------------------------------------------"
    wget https://download.mikrotik.com/routeros/$version/chr-$version.img.zip
    unzip chr-$version.img.zip                
    echo "---------------------------------------------------------------------------"
fi                                              
# List already existing VM's and ask for vmID
echo "== Printing list of VM's on this hypervisor!"
qm list                                                  
echo ""                                                      
read -p "Please Enter free vm ID to use:" vmID
echo ""                                                        
# Create storage dir for VM if needed.                      
if [ -d /var/lib/vz/images/$vmID ]           
then
    echo "-- VM Directory exists! Ideally try another vm ID!"
    read -p "Please Enter free vm ID to use:" vmID
else                                            
    echo "-- Creating VM image dir!"                         
    mkdir /var/lib/vz/images/$vmID
fi                                          
# Creating qcow2 image for CHR.                                       
echo "-- Converting image to qcow2 format "                         
qemu-img convert \                                                  
    -f raw \
    -O qcow2 \                    
    /root/temp/chr-$version.img \
    /var/lib/vz/images/$vmID/vm-$vmID-disk-1.qcow2
# Creating VM                      
echo "-- Creating new CHR VM"
qm create $vmID \                          
  --name chr-$version \              
  --net0 virtio,bridge=vmbr0 \       
  --bootdisk virtio0 \               
  --ostype l26 \                                              
  --memory 256 \   
  --onboot no \
  --sockets 1 \
  --cores 1 \
  --virtio0 local:$vmID/vm-$vmID-disk-1.qcow2
echo "############## End of Script ##############"
```

### Winbox Install
```sh
#!/usr/bin/env bash

# dpkg --add-architecture i386 && apt update && apt install wine32

# mv winbox.exe netinstall.exe /bin

# Добавляем в ~/.bashrc

### MikroTik ###
#alias dude='wine "/home/user/.wine/dosdevices/c:/Program Files/Dude/dude.exe"'
#alias netinstall='wine "/home/user/.wine/dosdevices/c:/Program Files/MikroTik/netinstall.exe"'
#alias winbox='wine "/home/user/.wine/dosdevices/c:/Program Files/MikroTik/winbox.exe"'
```

#### Resolution_install
```
#!/usr/bin/env bash

SCRIPT_PATH='/usr/share/resolution_set.sh'
LIGHTDM_CONF_FILE='/etc/lightdm/lightdm.conf'

cp ./resolution_set.sh $SCRIPT_PATH
chmod +x $SCRIPT_PATH

cp $LIGHTDM_CONF_FILE $LIGHTDM_CONF_FILE.bak
sed -i "s|#display-setup-script=|display-setup-script=$SCRIPT_PATH|" $LIGHTDM_CONF_FILE
```
#### Resolution_set
```
#!/usr/bin/env bash

X1=1280     # Ширина экрана
Y1=1024     # Высота экрана
F1=60       # Частота обновления, Гц
M1=VGA-1    # 

X2=1280
Y2=1024
F2=75
M2=VGA-1

MODE1=`cvt $X1 $Y1 $F1 | grep Modeline | sed 's/Modeline //'`
MODE2=`cvt $X2 $Y2 $F2 | grep Modeline | sed 's/Modeline //'`
MODE1_NAME=`echo $MODE1 | awk '{print $1}'`
MODE2_NAME=`echo $MODE2 | awk '{print $1}'`

xrandr --newmode $MODE1
xrandr --newmode $MODE2

xrandr --addmode $M1 $MODE1_NAME
xrandr --addmode $M2 $MODE2_NAME

xrandr --output $M1 --mode $MODE1_NAME
# xrandr --output $M2 --mode $MODE2_NAME
```

### Запись RTSP-потока в файл
```
openRTSP    -4 \
            -D 1 \
            -B 10000000 -b 10000000 \
            -w 1920 -h 1080 \
            -f $FRAME_RATE \
            -Q \
            -d $RECORDING_TIME \
            -t \
            -u $LOGIN $PASSWORD \
            $RTSP_URL > $FILE_RECORD

```