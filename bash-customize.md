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

Установка табуляции в 4 пробела (вместо 8-ми по умолчанию)
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
