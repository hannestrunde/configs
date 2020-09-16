#!/bin/bash

install_basic_packages () {
    printf "${BLUE}[*] Installing basic pkgs (root) ...${NC}\n"
    sudo apt -y install apt-transport-https golang
    sudo apt -y install git-core build-essential python-pip python3-pip net-tools bridge-utils ethtool dnsutils nmap
    sudo apt -y install proxychains wireshark
}

install_open_vm_tools () {
    printf "${BLUE}[*] Installing open-vm-tools (root) ...${NC}\n"
    sudo apt -y install libfuse-dev open-vm-tools-desktop fuse
}

setup_my_env () {
    printf "${BLUE}[*] Setting up my app environment (non-root) ...${NC}\n"
    mkdir -p ~/.myapps/bin
    MY_BIN_PATH="$HOME/tools/bin"
    echo '' >> ~/.bashrc
    echo '# Initialize my app environment' >> ~/.bashrc
    echo 'export PATH="$PATH:'"$MY_BIN_PATH"'"' >> ~/.bashrc
    . ~/.bashrc  
}

setup_go_env () {
    printf "${BLUE}[*] Setting up go environment (non-root) ...${NC}\n"
    echo '' >> ~/.bashrc
    echo '# Initialize go' >> ~/.bashrc
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    . ~/.bashrc
}

setup_python_env () {
    printf "${BLUE}[*] Setting up python user environment (non-root) ...${NC}\n"
    PYTHON_BIN_PATH="$(python -m site --user-base)/bin"
    echo '' >> ~/.bashrc
    echo '# Initialize python user environment' >> ~/.bashrc  
    echo 'export PATH="$PATH:'"$PYTHON_BIN_PATH"'"' >> ~/.bashrc
    . ~/.bashrc
}

install_virtualenvwrapper () {
    printf "${BLUE}[*] Installing virtualenvwrapper ...${NC}\n"
    pip install --user virtualenvwrapper
    echo '' >> ~/.bashrc
    echo '# Initialize virtualenvwrapper' >> ~/.bashrc
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
    echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.bashrc
    echo 'source $HOME/.local/bin/virtualenvwrapper.sh' >> ~/.bashrc
    . ~/.bashrc
}

install_docker () {
    printf "${BLUE}[*] Installing docker (root) ...${NC}\n"
    sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt remove docker docker-engine docker.io
    sudo apt -y install docker-ce
    sudo systemctl enable docker
}

install_mitm6 () {
    printf "${BLUE}[*] Installing mitm6 ...${NC}\n"
    # pip user install not possible; mitm6 needs root to run
    pip3 install mitm6
}

install_sqlplus () {
    printf "${BLUE}[*] Installing SQL*Plus ...${NC}\n"
    cd /tmp
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic-linuxx64.rpm
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-devel-linuxx64.rpm
    wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-sqlplus-linuxx64.rpm
    sudo apt -y install alien libaio1
    sudo alien -i oracle-instantclient-basic-*.rpm
    sudo alien -i oracle-instantclient-devel-*.rpm
    sudo alien -i oracle-instantclient-sqlplus-*.rpm
    echo /usr/lib/oracle/12.1/client/lib | sudo tee /etc/ld.so.conf.d/oracle.conf > /dev/null
    sudo ldconfig
}

install_adidnsdump () {
    printf "${BLUE}[*] Installing adidnsdump ...${NC}\n"
    mkvirtualenv adidnsdump
    mkdir ~/adipy3
    cd ~/adipy3
    git clone https://github.com/SecureAuthCorp/impacket.git
    cd impacket
    pip install .
    cd ~/adipy3
    git clone https://github.com/dirkjanm/adidnsdump
    cd adidnsdump
    pip install .
    deactivate
}

install_powerhub () {
    printf "${BLUE}[*] Installing PowerHub ...${NC}\n"
    cd ~/.myapps
    mkvirtualenv powerhub
    git clone https://github.com/AdrianVollmer/PowerHub
    cd PowerHub
    pip3 install --user -r requirements.txt
    echo '#!/bin/bash' > $HOME/.myapps/bin/powerhub
    echo 'cd $HOME/.myapps/PowerHub/ && python3 powerhub.py "$@"' >> $HOME/.myapps/bin/powerhub
    chmod +x $HOME/.myapps/bin/powerhub
    deactivate
}

install_pypykatz () {
    printf "${BLUE}[*] Installing pypykatz ...${NC}\n"
    pip3 install --user pypykatz
}

# Note: Download link needs to be changed regularly as there is no permalink available
install_silenttrinity () {
    printf "${BLUE}[*] Downloading latest SILENTTRINITY binary from byt3bl33d3r:master ...${NC}\n"
    cd /opt
    sudo mkdir silenttrinity
    cd silenttrinity
    sudo wget 'https://github.com/byt3bl33d3r/SILENTTRINITY/suites/283795555/artifacts/191398' -O st-ubuntu-latest.zip
    sudo unzip st-ubuntu-latest.zip
    cd st-ubuntu-latest
    sudo chmod +x st
    sudo ln -s /opt/silenttrinity/st-ubuntu-latest/st /usr/local/bin/st
}

install_cme_stable () {
    printf "${BLUE}[*] Installing CME stable ...${NC}\n"
    sudo apt -y install crackmapexec
}

# CME bleeding edge + lsassy
install_cme_bleeding_edge () {
    printf "${BLUE}[*] Installing CME bleeding edge and lsassy ...${NC}\n"
    sudo apt install -y libssl-dev libffi-dev python-dev build-essential
    cd /opt
    mkvirtualenv cme
    sudo git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
    cd CrackMapExec
    sudo python setup.py install
    #lsassy part
    sudo python3.7 -m pip install lsassy
    cd cme/modules
    sudo wget https://raw.githubusercontent.com/Hackndo/lsassy/master/cme/lsassy.py
    cd /opt/CrackMapExec
    sudo python setup.py install
    deactivate
}

# Impacket bleeding edge
install_impacket_bleeding_edge () {
    printf "${BLUE}[*] Installing impacket bleeding edge ...${NC}\n"
    cd /opt
    mkvirtualenv impacket
    sudo git clone https://github.com/SecureAuthCorp/impacket
    cd impacket
    # pip user install not possible; most impacket tools need root to run
    sudo pip install -r requirements.txt
    sudo python setup.py build
    sudo python setup.py install
    deactivate
}

install_bloodhound () {
    printf "${BLUE}[*] Installing bloodhound ...${NC}\n"
    sudo apt -y install bloodhound
}

install_empire () {
    printf "${BLUE}[*] Downloading Empire ...${NC}\n"
    cd /opt
    sudo git clone https://github.com/EmpireProject/Empire.git
    echo '#!/bin/bash' | sudo tee /usr/local/bin/empire > /dev/null
    echo 'cd /opt/Empire/ && ./empire "$@"' | sudo tee -a /usr/local/bin/empire > /dev/null
    sudo chmod +x /usr/local/bin/empire
}

install_empire_3.0 () {
    printf "${BLUE}[*] Installing Empire 3.0 docker container (~ 1 GB in size) ...${NC}\n"
    sudo docker pull bcsecurity/empire:latest
    sudo docker create -v empirevol:/empire --name empire bcsecurity/empire:latest
}

# EyeWitness Docker image
    printf "${BLUE}[*] Installing EyeWitness Docker container (non-root) ...${NC}\n"
    cd ~/.myapps
    git clone https://github.com/FortyNorthSecurity/EyeWitness.git
    cd EyeWitness/Python
    docker build --tag eyewitness .

install_eyewitness () {
    printf "${BLUE}[*] Installing EyeWitness ...${NC}\n"
    cd /opt
    sudo git clone https://github.com/ChrisTruncer/EyeWitness.git
    cd EyeWitness/setup
    sudo ./setup.sh
    echo '#!/bin/bash' | sudo tee /usr/local/bin/eyewitness > /dev/null
    echo 'cd /opt/EyeWitness/ && ./EyeWitness.py "$@"' | sudo tee -a /usr/local/bin/eyewitness > /dev/null
    sudo chmod +x /usr/local/bin/eyewitness
}

install_nikto_docker () {
    printf "${BLUE}[*] Installing Nikto Docker container ...${NC}\n"
    cd /opt
    sudo git clone https://github.com/sullo/nikto.git
    cd nikto
    sudo docker build -t sullo/nikto .
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
    sudo git clone https://github.com/lgandx/Responder.git
    echo '#!/bin/bash' | sudo tee /usr/local/bin/responder-dev > /dev/null
    echo 'cd /opt/Responder/ && ./Responder.py "$@"' | sudo tee -a /usr/local/bin/responder-dev > /dev/null
    sudo chmod +x /usr/local/bin/responder-dev
}

install_gobuster () {
    printf "${BLUE}[*] Installing gobuster ...${NC}\n"
    go get github.com/OJ/gobuster
}

install_ffuf () {
    printf "${BLUE}[*] Installing ffuf (non-root install and usage) ...${NC}\n"
    go get github.com/ffuf/ffuf
}

install_windapsearch () {
    printf "${BLUE}[*] Installing windapsearch ...${NC}\n"
    mkvirtualenv windapsearch
    sudo apt -y install libsasl2-dev python-dev libldap2-dev libssl-dev
    pip install python-ldap
    cd /opt
    sudo git clone https://github.com/ropnop/windapsearch.git
    sudo ln -s /opt/windapsearch/windapsearch.py /usr/local/bin/windapsearch
    deactivate
}

install_impacket_static_binaries () {
    printf "${BLUE}[*] Downloading some of @ropnop's latest stable impacket static binaries ...${NC}\n"
    cd /opt
    sudo mkdir impacket-static-binaries
    cd impacket-static-binaries
    sudo wget 'https://github.com/ropnop/impacket_static_binaries/releases/latest/download/GetUserSPNs_linux_x86_64'
    sudo wget 'https://github.com/ropnop/impacket_static_binaries/releases/latest/download/getTGT_linux_x86_64'
    sudo chmod +x GetUserSPNs_linux_x86_64
    sudo chmod +x getTGT_linux_x86_64
    sudo ln -s /opt/impacket-static-binaries/GetUserSPNs_linux_x86_64 /usr/local/bin/getuserspns
    sudo ln -s /opt/impacket-static-binaries/getTGT_linux_x86_64 /usr/local/bin/gettgt
}

install_kerbrute () {
    printf "${BLUE}[*] Downloading @ropnop's latest kerbrute release ...${NC}\n"
    cd /opt
    sudo mkdir kerbrute
    cd kerbrute
    sudo wget 'https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64'
    sudo chmod +x kerbrute_linux_amd64
    sudo ln -s /opt/kerbrute/kerbrute_linux_amd64 /usr/local/bin/kerbrute
}

# Disable rpcbind.socket (listening on 0.0.0.0:111)
disable_rpcbind () {
    printf "${BLUE}[*] Trying to disable rpcbind.socket ...${NC}\n"
    sudo systemctl stop rpcbind.socket
    sudo systemctl disable rpcbind.socket
}

configure_tmux () {
    printf "${BLUE}[*] Downloading tmux.conf ...${NC}\n"
    cd ~
    wget https://raw.githubusercontent.com/cyberfreaq/configs/master/.tmux.conf
}

configure_time () {
    sudo apt -y install ntpdate
    sudo ntpdate de.pool.ntp.org
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
sudo apt-get update
install_basic_packages
install_open_vm_tools
setup_my_env
setup_go_env
setup_python_env
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
#install_empire_3.0
install_eyewitness
install_nikto_docker
install_responder_bleeding_edge
install_gobuster
install_ffuf
install_windapsearch
install_impacket_static_binaries
install_kerbrute

## Configuration stuff
printf "${BLUE}[+] Starting configuration stuff ...${NC}\n"
disable_rpcbind
configure_tmux

## Outdated
#install_empire
#configure_time

## What is left to do manually?

printf "${YELLOW}\n\n[+] LEFT TO DO${NC}\n"

printf ' - Change neo4j DB password\n'
printf '   https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/\n\n'

#printf ' - Finish installing Empire\n'
#printf '   cd /opt/Empire && bash setup/install.sh\n\n'

printf ' - Reboot system\n\n'
