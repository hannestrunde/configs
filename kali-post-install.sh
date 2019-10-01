#!/bin/bash
## Basic pkgs
echo '[+] Installing basic pkgs ...'
sudo apt-get update
sudo apt-get -y install apt-transport-https
sudo apt-get update

# Virtualenvwrapper
echo '[+] Installing virtualenvwrapper ...'
pip install virtualenvwrapper
echo '' >> ~/.bashrc
echo '# Initialize virtualenvwrapper' >> ~/.bashrc
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'export PROJECT_HOME=$HOME/Devel' >> ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc

## Pentest stuff
echo '[+] Installing pentest stuff ...'

# CME stable
echo '[*] Installing CME stable ...'
apt-get install crackmapexec

# CME bleeding edge
echo '[*] Installing CME bleeding edge ...'
apt-get install -y libssl-dev libffi-dev python-dev build-essential
cd /opt
mkvirtualenv cme
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec
python setup.py install
deactivate
cd /opt

# Impacket bleeding edge
echo '[*] Installing impacket bleeding edge ...'
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
echo '[*] Installing bloodhound ...'
apt-get install bloodhound

# Empire
echo '[*] Installing Empire ...'
cd /opt
git clone https://github.com/EmpireProject/Empire.git
cd Empire/setup/
./install.sh
ln -s /opt/Empire/empire /usr/local/bin/empire

# Other
echo '[*] Installing gobuster ...'
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
echo '   \ https://portswigger.net/users
echo ' - Reboot system
echo ''
echo ''
