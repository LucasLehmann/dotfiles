# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth:reasedups

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s histreedit
shopt -s histverify

PROMPT_COMMAND+="history -a; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######

export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

#shopt -s autocd # Automatically cd into dir without typing cd
complete -cf doas # Doas tab completion

eval "$(starship init bash)"
eval "$(zoxide init bash)" && alias cd='z'
#eval "$(atuin init bash)"
[ -z $TMUX ] && (tmux -u a || tmux -u)

alias \
poweroff='doas /sbin/poweroff' \
reboot='doas /sbin/reboot' \
neofetch='neowofetch' \
doas='doas --' \
cp='cp -iv' \
rm='rm -Iv' \
grep='rg' \
df='df -h' \
du='du -h' \
du='dust' \
eza='eza -l -hM --smart-group --group-directories-first --no-quotes --icons' \
ezaa='eza -l -hM --git --git-repos --total-size --smart-group --group-directories-first --no-quotes --icons' \
l='\eza' \
ls='eza' \
la='eza -a' \
lt='eza -T' \
ld='eza -TD' \
lg='eza --git --git-repos' \
lsz='eza --total-size' \
tree='eza --tree' \
mkdir='mkdir -pv' \
bat='batcat' \
cat='bat'

alias dos2unix="sed -i.bak 's/\r$//'"
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias xbindkeys='xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'

HISTIGNORE+=$'[ \t]*:&:[fb]g:exit:ls:la:lt:ld:clear'

extract () {
  for n in "$@"
  do
     if [ -f $n ] ; then
         case $n in
             *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                          tar xvf ./$n     ;;
             *.lzma)      unlzma ./$n      ;;
             *.bz2)       bunzip2 ./$n     ;;
             *.cbr|*.rar) unrar x ./$n     ;;
             *.gz)        gunzip ./$n      ;;
             *.cbz|*.epub|*.zip)       unzip ./$n       ;;
             *.Z)         uncompress ./$n  ;;
             *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xrar)
                          7z x ./$n        ;;
             *.tar.zst)   unzstd ./$n      ;;
             *.xz)        unxz ./$n        ;;
             *.exe)       cabextract ./$n  ;;
             *.cpio)      cpio -id < ./$n  ;;
             *.cba|*.ace) unace x ./$n     ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
  done
}
