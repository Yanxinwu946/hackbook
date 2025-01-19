把下面内容添加到用户的 `.zshrc` 文件中
```
# -------------------- Custom Variables --------------------
myip=$(ip addr show tun0 | grep -oP 'inet \K[\d.]+') 
myip0=$(ip addr show eth0 | grep -oP 'inet \K[\d.]+') 
myip1=$(ip addr show eth1 | grep -oP 'inet \K[\d.]+') 
smbAddress="\\\\\\${myip}\\share"

# -------------------- Efficiency Aliases --------------------
alias lla='ls -lah --color=auto' 
alias oscp='cd ~/OSCP'
alias ..='cd ..'
alias ...='cd ../..'
alias py='python3'
alias sshkeygen='ssh-keygen -t rsa -b 4096'

# -------------------- Custom Functions --------------------
mkcd() { mkdir -p "$1" && cd "$1"; } 
f() { find "${2:-/}" -iname "*$1*" 2>/dev/null; }
ff() { find "${2:-/}" -iname "$1" 2>/dev/null; }
hc() { hashcat "$1" /usr/share/wordlists/rockyou.txt "${@:2}" -O; }
httphere() { python3 -m http.server "${1:-80}"; }
smbserver() {
    echo -ne "\033]0;SMBserv\007"
    echo "net use x: $smbAddress /user:sender password"
    impacket-smbserver share . -username sender -password password -smb2support
}
```
