#!/bin/bash
# Constans
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Print usage warning
printf "[!] Make sure to run the script with '${RED}. kali-post-install.sh${NC}' instead of 'sh ./kali-post-install.sh!\n"
printf "[!] If you ignore this warning, stuff will likely break!\n"
read -p "Press any key to proceed or Strg+C to cancel ..." x

## Basic pkgs
printf "${BLUE}[+] Installing basic pkgs ...${NC}\n"
sudo apt-get update
sudo apt-get -y install apt-transport-https golang
sudo apt-get update

# Set up go environment
printf "${BLUE}[+] Setting up go environment ...${NC}\n"
echo '' >> ~/.bashrc
echo '# Initialize go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
. ~/.bashrc

# Virtualenvwrapper
printf "${BLUE}[+] Installing virtualenvwrapper ...${NC}\n"
pip install virtualenvwrapper
echo '' >> ~/.bashrc
echo '# Initialize virtualenvwrapper' >> ~/.bashrc
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
. ~/.bashrc

# Docker
printf "${BLUE}[+] Installing docker ...${NC}\n"
apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get remove docker docker-engine docker.io
apt-get -y install docker-ce
systemctl enable docker

## Pentest stuff
printf "${BLUE}[+] Installing pentest stuff ...${NC}\n"

# CME stable
printf "${BLUE}[*] Installing CME stable ...${NC}\n"
apt-get -y install crackmapexec

# CME bleeding edge
printf "${BLUE}[*] Installing CME bleeding edge ...${NC}\n"
apt-get install -y libssl-dev libffi-dev python-dev build-essential
cd /opt
mkvirtualenv cme
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec
python setup.py install
deactivate

# Impacket bleeding edge
printf "${BLUE}[*] Installing impacket bleeding edge ...${NC}\n"
cd /opt
mkvirtualenv impacket
git clone https://github.com/SecureAuthCorp/impacket
cd impacket
pip install -r requirements.txt
python setup.py build
python setup.py install
deactivate

# Bloodhound
printf "${BLUE}[*] Installing bloodhound ...${NC}\n"
apt-get -y install bloodhound

# Empire
printf "${BLUE}[*] Downloading Empire ...${NC}\n"
cd /opt
git clone https://github.com/EmpireProject/Empire.git
echo '#!/bin/bash' >> /usr/local/bin/empire
echo '' >> /usr/local/bin/empire
echo 'cd /opt/Empire/ && ./empire "$@"' >> /usr/local/bin/empire
chmod +x /usr/local/bin/empire

# EyeWitness Docker
printf "${BLUE}[*] Installing EyeWitness Docker container ...${NC}\n"
cd /opt
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness
docker build --build-arg user=$USER --tag eyewitness .

# Nikto bleeding Edge
printf "${BLUE}[*] Installing Nikto bleeding edge ...${NC}\n"
cd /opt
git clone https://github.com/sullo/nikto.git
echo '#!/bin/sh' >> /usr/local/bin/nikto-dev
echo ''
echo 'set -e' >> /usr/local/bin/nikto-dev
echo 'exec /opt/nikto/program/nikto.pl "$@"' >> /usr/local/bin/nikto-dev
chmod +x /usr/local/bin/nikto-dev

# lgandx/Responder bleeding edge
printf "${BLUE}[*] Installing responder bleeding edge ...${NC}\n"
cd /opt
git clone https://github.com/lgandx/Responder.git
echo '#!/bin/bash' >> /usr/local/bin/responder-dev
echo '' >> /usr/local/bin/responder-dev
echo 'cd /opt/Responder/ && ./Responder.py "$@"' >> /usr/local/bin/responder-dev
chmod +x /usr/local/bin/responder-dev

# gobuster
printf "${BLUE}[*] Installing gobuster ...${NC}"
go get github.com/OJ/gobuster

# windapsearch
printf "${BLUE}[*] Installing windapsearch ...${NC}"
apt-get -y install python-ldap
cd /opt
git clone https://github.com/ropnop/windapsearch.git
ln -s /opt/windapsearch/windapsearch.py /usr/local/bin/windapsearch

## Configuration stuff
printf "${BLUE}[+] Starting configuration stuff ...${NC}\n"

# Disable rpcbind.socket (listening on 0.0.0.0:111)
printf "${BLUE}[*] Trying to disable rpcbind.socket ...${NC}"
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket

## What is left to do manually?
printf "${YELLOW}\n\n[+] LEFT TO DO${NC}\n"

printf ' - Change neo4j DB password\n'
printf '   https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/\n\n'

printf ' - Finish installing Empire\n'
printf '   cd /opt/Empire && bash setup/install.sh\n\n'

printf ' - Reboot system\n\n'
