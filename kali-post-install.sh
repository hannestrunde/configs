#!/bin/bash
# Constans
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

## Basic pkgs
printf "${BLUE}[+] Installing basic pkgs ...${NC}\n"
sudo apt-get update
sudo apt-get -y install apt-transport-https
sudo apt-get update

# Virtualenvwrapper
printf "${BLUE}[+] Installing virtualenvwrapper ...${NC}\n"
pip install virtualenvwrapper
echo '' >> ~/.bashrc
echo '# Initialize virtualenvwrapper' >> ~/.bashrc
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc

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
apt-get install crackmapexec

# CME bleeding edge
printf "${BLUE}[*] Installing CME bleeding edge ...${NC}\n"
apt-get install -y libssl-dev libffi-dev python-dev build-essential
cd /opt
mkvirtualenv cme
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec
python setup.py install
deactivate
cd /opt

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
cd /opt

# Bloodhound
printf "${BLUE}[*] Installing bloodhound ...${NC}\n"
apt-get install bloodhound

# Empire
printf "${BLUE}[*] Downloading Empire ...${NC}\n"
cd /opt
git clone https://github.com/EmpireProject/Empire.git

# Other
printf "${BLUE}[*] Installing gobuster ...${NC}"
go get github.com/OJ/gobuster

echo ''
echo ''
echo '##############################'
echo '#         LEFT TO DO         #'
echo '##############################'
echo ' - Change neo4j DB password'
echo '   \ https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling/'
echo ' - Finish installing Empire'
echo '   \ cd /opt/Empire && bash setup/install.sh'
echo ' - Install BurpSuite Pro'
echo '   \ https://portswigger.net/users'
echo ' - Reboot system'
echo ''
echo ''
