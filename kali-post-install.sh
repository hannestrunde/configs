#!/bin/bash

install_basic_packages () {
    printf "${BLUE}[*] Installing basic pkgs ...${NC}\n"
    apt-get -y install apt-transport-https golang
    apt-get -y install git-core build-essential python3-pip net-tools bridge-utils ethtool dnsutils nmap
    apt-get -y install proxychains wireshark
}

install_open_vm_tools () {
    printf "${BLUE}[*] Installing open-vm-tools ...${NC}\n"
    apt-get -y libfuse-dev open-vm-tools-desktop fuse
}

setup_go_env () {
    printf "${BLUE}[*] Setting up go environment ...${NC}\n"
    echo '' >> ~/.zshrc
    echo '# Initialize go' >> ~/.zshrc
    echo 'export GOPATH=$HOME/go' >> ~/.zshrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.zshrc
    . ~/.zshrc
}

install_virtualenvwrapper () {
    printf "${BLUE}[*] Installing virtualenvwrapper ...${NC}\n"
    pip3 install virtualenvwrapper
    echo '' >> ~/.zshrc
    echo '# Initialize virtualenvwrapper' >> ~/.zshrc
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.zshrc
    echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.zshrc
    echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> ~/.zshrc
    echo 'export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv' >> ~/.zshrc
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.zshrc
    . ~/.zshrc
}

install_docker () {
    printf "${BLUE}[*] Installing docker ...${NC}\n"
    apt-get remove docker docker-engine docker.io containerd runc
    apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
    apt-get update
    apt-get -y install docker-ce docker-ce-cli containerd.io
    systemctl enable docker
    printf "${BLUE}[*] Installing docker-compose ...${NC}\n"
    curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

install_azure-cli () {
    printf "${BLUE}[*] Installing azure-cli ...${NC}\n"
    apt-get -y install azure-cli
}

install_azure_stormspotter () {
    printf "${BLUE}[*] Installing Azure Stormspotter ...${NC}\n"
    cd /opt
    git clone https://github.com/Azure/Stormspotter
    cd Stormspotter
    docker-compose up --no-start
}

install_roadrecon () {
    printf "${BLUE}[*] Installing ROADrecon ...${NC}\n"
    pip3 install roadrecon
}

install_scoutsuite () {
    printf "${BLUE}[*] Installing ScoutSuite ...${NC}\n"
    cd /opt
    mkvirtualenv scoutsuite
    git clone https://github.com/nccgroup/ScoutSuite
    cd ScoutSuite
    pip3 install -r requirements.txt
    echo '#!/bin/zsh' > /usr/local/bin/scout
    echo 'cd /opt/ScoutSuite/ && python3 scout.py "$@"' >> /usr/local/bin/scout
    chmod +x /usr/local/bin/scout
    deactivate
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

install_rdp_sec_check () {
    echo | cpan install Encoding::BER
    cd /opt
    git clone https://github.com/CiscoCXSecurity/rdp-sec-check.git
    cd rdp-sec-check
    chmod +x rdp-sec-check.pl
    ln -s /opt/rdp-sec-check/rdp-sec-check.pl /usr/local/bin/rdp-sec-check
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

install_cme_stable () {
    printf "${BLUE}[*] Installing CME stable ...${NC}\n"
    apt-get -y install crackmapexec
}

install_cme_latest () {
    printf "${BLUE}[*] Downloading latest CME release ...${NC}"
    cd /opt
    mkdir cme
    cd cme
    wget 'https://github.com/byt3bl33d3r/CrackMapExec/releases/latest/download/cme-ubuntu-latest.4.zip'
    unzip cme-ubuntu-latest.4.zip
    chmod +x cme
    ln -s /opt/cme/cme /usr/local/bin/cme
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

install_empire_3.0 () {
    printf "${BLUE}[*] Installing Empire 3.0 docker container (~ 1 GB in size) ...${NC}\n"
    docker pull bcsecurity/empire:latest
    docker create -v empirevol:/empire --name empire bcsecurity/empire:latest
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
    cd EyeWitness/Python/setup
    ./setup.sh
    echo '#!/bin/bash' > /usr/local/bin/eyewitness
    echo 'cd /opt/EyeWitness/Python && ./EyeWitness.py "$@"' >> /usr/local/bin/eyewitness
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

install_ffuf () {
    printf "${BLUE}[*] Installing ffuf ...${NC}\n"
    go get github.com/ffuf/ffuf
}

install_windapsearch () {
    printf "${BLUE}[*] Installing windapsearch ...${NC}"
    apt-get -y install python-ldap
    cd /opt
    git clone https://github.com/ropnop/windapsearch.git
    ln -s /opt/windapsearch/windapsearch.py /usr/local/bin/windapsearch
}

install_go-windapsearch () {
    printf "${BLUE}[*] Downloading @ropnop's latest go-windapsearch release ...${NC}"
    cd /opt
    mkdir go-windapsearch
    cd go-windapsearch
    wget 'https://github.com/ropnop/go-windapsearch/releases/latest/download/windapsearch-linux-amd64'
    chmod +x windapsearch-linux-amd64
    ln -s /opt/go-windapsearch/windapsearch-linux-amd64 /usr/local/bin/windapsearch
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
install_eyewitness # installed first because it clears the install log
install_basic_packages
#install_open_vm_tools # not necessary when using Kali VMware image
setup_go_env
install_virtualenvwrapper
install_docker

## Install pentest stuff
printf "${BLUE}[+] Installing pentest stuff ...${NC}\n"
install_azure-cli
install_azure_stormspotter
install_roadrecon
install_mitm6
install_sqlplus
install_rdp_sec_check
install_adidnsdump
install_powerhub
install_pypykatz
install_cme_stable
install_cme_latest
install_impacket_bleeding_edge
install_bloodhound
#install_empire_3.0
install_nikto_docker
install_responder_bleeding_edge
install_gobuster
install_ffuf
#install_windapsearch # replaced by go-windapsearch (both are started via "windapsearch" so make sure you only install one of them)
install_go-windapsearch
install_impacket_static_binaries
install_kerbrute

## Outdated
#install_empire

## Configuration stuff
printf "${BLUE}[+] Starting configuration stuff ...${NC}\n"
disable_rpcbind
configure_tmux
configure_time

## What is left to do manually?

printf "${YELLOW}\n\n[+] LEFT TO DO${NC}\n"

printf ' - Change neo4j DB password\n'
printf '   https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/\n\n'

printf ' - Download and install SILENTTRINITY\n'
printf '   https://github.com/byt3bl33d3r/SILENTTRINITY/actions\n'
printf '   cd /opt; mkdir silenttrinity; cd silenttrinity\n'
printf '   copy st-ubuntu-latest.zip into new directory\n'
printf '   unzip st-ubuntu-latest.zip; chmod +x st; sudo ln -s /opt/silenttrinity/st /usr/local/bin/st\n\n'

#printf ' - Finish installing Empire\n'
#printf '   cd /opt/Empire && bash setup/install.sh\n\n'

printf ' - Reboot system\n\n'
