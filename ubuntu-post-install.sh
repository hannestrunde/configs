#!/bin/bash
sudo apt-get update
sudo apt-get -y install apt-transport-https
sudo apt-get update

# VMware Tools
sudo apt-get -y install -y open-vm-tools-desktop fuse

## Dev Tools
# Git
sudo apt-get -y install git

# VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get -y install code

# Ruby
sudo apt-get -y install ruby-full

# Jekyll
gem install jekyll bundler
