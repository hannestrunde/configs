#!/bin/bash
# Constans

install_basic_packages () {
    printf "${BLUE}[*] Installing basic pkgs ...${NC}\n"
    apt-get -y install apt-transport-https golang
    apt-get -y install git-core build-essential python-pip python3-pip net-tools bridge-utils ethtool dnsutils nmap
    apt-get -y install proxychains wireshark
}

install_open_vm_tools () {
    printf "${BLUE}[*] Installing open-vm-tools ...${NC}\n"
    apt-get -y libfuse-dev open-vm-tools-desktop fuse
}

setup_go_env () {
    printf "${BLUE}[*] Setting up go environment ...${NC}\n"
    echo '' >> ~/.bashrc
    echo '# Initialize go' >> ~/.bashrc
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    . ~/.bashrc
}

install_virtualenvwrapper () {
    printf "${BLUE}[*] Installing virtualenvwrapper ...${NC}\n"
    pip install virtualenvwrapper
    echo '' >> ~/.bashrc
    echo '# Initialize virtualenvwrapper' >> ~/.bashrc
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
    echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.bashrc
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
    . ~/.bashrc
}

install_docker () {
    printf "${BLUE}[*] Installing docker ...${NC}\n"
    apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
    apt-get remove docker docker-engine docker.io
    apt-get -y install docker-ce
    systemctl enable docker
}

install_mitm6 () {
    printf "${BLUE}[*] Installing mitm6 ...${NC}\n"
    pip3 install mitm6
}

install_sqlplus () {
    printf "${BLUE}[*] Installing SQL*Plus ...${NC}\n"
    cd /tmp
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic-linuxx64.rpm
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-devel-linuxx64.rpm
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-sqlplus-linuxx64.rpm
    apt-get -y install alien libaio1
    alien -i oracle-instantclient-basic-*.rpm
    alien -i oracle-instantclient-devel-*.rpm
    alien -i oracle-instantclient-sqlplus-*.rpm
    echo /usr/lib/oracle/12.1/client/lib > /etc/ld.so.conf.d/oracle.conf
    ldconfig
}

install_adidnsdump () {
    printf "${BLUE}[*] Installing adidnsdump ...${NC}\n"
    pip install git+https://github.com/dirkjanm/adidnsdump#egg=adidnsdump
}

install_powerhub () {
    printf "${BLUE}[*] Installing PowerHub ...${NC}\n"
    cd /opt
    mkvirtualenv powerhub
    git clone https://github.com/AdrianVollmer/PowerHub
    cd PowerHub
    pip3 install -r requirements.txt
    echo '#!/bin/bash' > /usr/local/bin/powerhub
    echo 'cd /opt/PowerHub/ && python3 powerhub.py "$@"' >> /usr/local/bin/powerhub
    chmod +x /usr/local/bin/powerhub
    deactivate
}

install_pypykatz () {
    printf "${BLUE}[*] Installing pypykatz ...${NC}\n"
    pip3 install pypykatz
}

# Note: Download link needs to be changed regularly as there is no permalink available
install_silenttrinity () {
    printf "${BLUE}[*] Downloading latest SILENTTRINITY binary from byt3bl33d3r:master ...${NC}\n"
    cd /opt
    mkdir silenttrinity
    cd silenttrinity
    wget 'https://github.com/byt3bl33d3r/SILENTTRINITY/suites/283795555/artifacts/191398' -O st-ubuntu-latest.zip
    unzip st-ubuntu-latest.zip
    cd st-ubuntu-latest
    chmod +x st
    ln -s /opt/silenttrinity/st-ubuntu-latest/st /usr/local/bin/silenttrinity
}

install_cme_stable () {
    printf "${BLUE}[*] Installing CME stable ...${NC}\n"
    apt-get -y install crackmapexec
}

# CME bleeding edge + lsassy
install_cme_bleeding_edge () {
    printf "${BLUE}[*] Installing CME bleeding edge and lsassy ...${NC}\n"
    apt-get install -y libssl-dev libffi-dev python-dev build-essential
    cd /opt
    mkvirtualenv cme
    git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
    cd CrackMapExec
    python setup.py install
    #lsassy part
    python3.7 -m pip install lsassy
    cd cme/modules
    wget https://raw.githubusercontent.com/Hackndo/lsassy/master/cme/lsassy.py
    cd /opt/CrackMapExec
    python setup.py install
    deactivate
}

# Impacket bleeding edge
install_impacket_bleeding_edge () {
    printf "${BLUE}[*] Installing impacket bleeding edge ...${NC}\n"
    cd /opt
    mkvirtualenv impacket
    git clone https://github.com/SecureAuthCorp/impacket
    cd impacket
    pip install -r requirements.txt
    python setup.py build
    python setup.py install
    deactivate
}

install_bloodhound () {
    printf "${BLUE}[*] Installing bloodhound ...${NC}\n"
    apt-get -y install bloodhound
}

install_empire () {
    printf "${BLUE}[*] Downloading Empire ...${NC}\n"
    cd /opt
    git clone https://github.com/EmpireProject/Empire.git
    echo '#!/bin/bash' > /usr/local/bin/empire
    echo 'cd /opt/Empire/ && ./empire "$@"' >> /usr/local/bin/empire
    chmod +x /usr/local/bin/empire
}

# EyeWitness Docker image
#printf "${BLUE}[*] Installing EyeWitness Docker container ...${NC}\n"
#cd /opt
#git clone https://github.com/FortyNorthSecurity/EyeWitness.git
#cd EyeWitness
#docker build --tag eyewitness .

install_eyewitness () {
    printf "${BLUE}[*] Installing EyeWitness ...${NC}\n"
    cd /opt
    git clone https://github.com/ChrisTruncer/EyeWitness.git
    cd EyeWitness/setup
    ./setup.sh
    echo '#!/bin/bash' > /usr/local/bin/eyewitness
    echo 'cd /opt/EyeWitness/ && ./EyeWitness.py "$@"' >> /usr/local/bin/eyewitness
    chmod +x /usr/local/bin/eyewitness
}

install_nikto_docker () {
    printf "${BLUE}[*] Installing Nikto Docker container ...${NC}\n"
    cd /opt
    git clone https://github.com/sullo/nikto.git
    cd nikto
    docker build -t sullo/nikto .
}

# Nikto bleeding Edge
#printf "${BLUE}[*] Installing Nikto bleeding edge ...${NC}\n"
#cd /opt
#git clone https://github.com/sullo/nikto.git
#echo '#!/bin/sh' >> /usr/local/bin/nikto-dev
#echo ''
#echo 'set -e' >> /usr/local/bin/nikto-dev
#echo 'exec /opt/nikto/program/nikto.pl "$@"' >> /usr/local/bin/nikto-dev
#chmod +x /usr/local/bin/nikto-dev

install_responder_bleeding_edge () {
    printf "${BLUE}[*] Installing responder bleeding edge ...${NC}\n"
    cd /opt
    git clone https://github.com/lgandx/Responder.git
    echo '#!/bin/bash' > /usr/local/bin/responder-dev
    echo 'cd /opt/Responder/ && ./Responder.py "$@"' >> /usr/local/bin/responder-dev
    chmod +x /usr/local/bin/responder-dev
}

install_gobuster () {
    printf "${BLUE}[*] Installing gobuster ...${NC}"
    go get github.com/OJ/gobuster
}

install_windapsearch () {
    printf "${BLUE}[*] Installing windapsearch ...${NC}"
    apt-get -y install python-ldap
    cd /opt
    git clone https://github.com/ropnop/windapsearch.git
    ln -s /opt/windapsearch/windapsearch.py /usr/local/bin/windapsearch
}

install_impacket_static_binaries () {
    printf "${BLUE}[*] Downloading some of @ropnop's latest stable impacket static binaries ...${NC}"
    cd /opt
    mkdir impacket-static-binaries
    cd impacket-static-binaries
    wget 'https://github.com/ropnop/impacket_static_binaries/releases/latest/download/GetUserSPNs_linux_x86_64'
    wget 'https://github.com/ropnop/impacket_static_binaries/releases/latest/download/getTGT_linux_x86_64'
    chmod +x GetUserSPNs_linux_x86_64
    chmod +x getTGT_linux_x86_64
    ln -s /opt/impacket-static-binaries/GetUserSPNs_linux_x86_64 /usr/local/bin/getuserspns
    ln -s /opt/impacket-static-binaries/getTGT_linux_x86_64 /usr/local/bin/gettgt
}

install_kerbrute () {
    printf "${BLUE}[*] Downloading @ropnop's latest kerbrute release ...${NC}"
    cd /opt
    mkdir kerbrute
    cd kerbrute
    wget 'https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64'
    chmod +x kerbrute_linux_amd64
    ln -s /opt/kerbrute/kerbrute_linux_amd64 /usr/local/bin/kerbrute
}

# Disable rpcbind.socket (listening on 0.0.0.0:111)
disable_rpcbind () {
    printf "${BLUE}[*] Trying to disable rpcbind.socket ...${NC}"
    systemctl stop rpcbind.socket
    systemctl disable rpcbind.socket
}

configure_tmux () {
    printf "${BLUE}[*] Downloading tmux.conf ...${NC}"
    cd ~
    wget https://raw.githubusercontent.com/cyberfreaq/configs/master/.tmux.conf
}

configure_time () {
    apt-get -y install ntpdate
    ntpdate de.pool.ntp.org
}

################ MAIN SECTION ###############

## Color Coding
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

## Print usage warning
printf "[!] Make sure to run the script with '${RED}. kali-post-install.sh${NC}' instead of 'sh ./kali-post-install.sh!\n"
printf "[!] If you ignore this warning, stuff will likely break!\n"
read -p "Press any key to proceed or Strg+C to cancel ..." x

## Install basic stuff and prerequisites
printf "${BLUE}[+] Installing basic stuff and prerequisites ...${NC}\n"
apt-get update
install_basic_packages
install_open_vm_tools
setup_go_env
install_virtualenvwrapper
install_docker

## Install pentest stuff
printf "${BLUE}[+] Installing pentest stuff ...${NC}\n"
install_mitm6
install_sqlplus
install_adidnsdump
install_powerhub
install_pypykatz
install_silenttrinity
install_cme_stable
install_cme_bleeding_edge
install_impacket_bleeding_edge
install_bloodhound
install_empire
install_eyewitness
install_nikto_docker
install_responder_bleeding_edge
install_gobuster
install_windapsearch
install_impacket_static_binaries
install_kerbrute

## Configuration stuff
printf "${BLUE}[+] Starting configuration stuff ...${NC}\n"
disable_rpcbind
configure_tmux
configure_time

## What is left to do manually?

printf "${YELLOW}\n\n[+] LEFT TO DO${NC}\n"

printf ' - Change neo4j DB password\n'
printf '   https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/\n\n'

printf ' - Finish installing Empire\n'
printf '   cd /opt/Empire && bash setup/install.sh\n\n'

printf ' - Reboot system\n\n'
