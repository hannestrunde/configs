# Description
## win10-preset.txt
A custom preset file to use with https://github.com/Disassembler0/Win10-Initial-Setup-Script/

# Todo
## kali-post-install.zsh
- [X] Add ScoutSuite
- [X] Add https://github.com/CiscoCXSecurity/rdp-sec-check
- [X] Add https://github.com/ropnop/go-windapsearch 
- [X] Add https://github.com/Azure/Stormspotter
- [X] Add roadrecon

# Known Issues
## kali-post-install.zsh
- "printf" and "read" command appear in wrong order when running the script
- Somewhere during the installation Kali asks for a password for a new "Default" keyring
  - Workaround: apt -y install seahorse; open application "Passwords and Keys" and create new "Password Keyring" with name "Default" (choose any pw you like)
