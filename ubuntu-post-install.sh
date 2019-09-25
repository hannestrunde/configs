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
sudo snap install --classic code

# Ruby
sudo apt-get -y install ruby-full

# Jekyll
sudo gem install jekyll bundler
