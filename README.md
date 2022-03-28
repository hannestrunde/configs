# Description
## win10-preset.txt 
A custom preset file to use with https://github.com/Disassembler0/Win10-Initial-Setup-Script/

# Todo
## kali-post-install.zsh
- [ ] Add jconsole 
- [X] Add https://github.com/cube0x0/CVE-2021-1675
- [X] Add https://github.com/byt3bl33d3r/ItWasAllADream
- [ ] Download and unzip Processhacker
- [ ] Install EyeWitness via apt?
- [ ] Configure Samba readonly and write shares
- [ ] Change /usr/local/bin links to 'python3 /opt/folder/tool.py "$@"' instead of 'cd /opt/folder/.....' to make sure that file parameters are working from the current directory
- [ ] Add nuclei
- [X] Add masscan from Repo
- [X] Add https://github.com/CBHue/PyFuscation
- [X] Add silentbridge
- [X] Add https://github.com/dirkjanm/krbrelayx
- [ ] Add https://github.com/saravana815/dhtest.git
- [X] Add https://github.com/knavesec/Max
- [ ] Add https://github.com/dirkjanm/PrivExchange
- [ ] Add zerologon_tester.py
- [ ] Add bloodhound 4.0
- [ ] install_bloodhound (): add neo4j Config to repo and download and replace (Listening on 0.0.0.0)
- [X] install_lsassy (): Download procdump to /root/tools/procdump
    - https://download.sysinternals.com/files/Procdump.zip
- [X] Add pypykatz
- [ ] Add https://github.com/preempt/ntlm-scanner
  - Also consider this PR: https://github.com/preempt/ntlm-scanner/pull/1
- [X] Add ScoutSuite
- [X] Add https://github.com/CiscoCXSecurity/rdp-sec-check
- [X] Add https://github.com/ropnop/go-windapsearch 
- [X] Add https://github.com/Azure/Stormspotter
- [X] Add roadrecon

## w10-vm-post-install.ps1
- [ ] Create PS1 Script
- [ ] Install Azure Powershell
- [ ] Install Azure AD Powershell
- [ ] Install AD Powershell (RSAT)
- [ ] Download current SysInternals

# Known Issues
## kali-post-install.zsh
- "printf" and "read" command appear in wrong order when running the script
- Somewhere during the installation Kali asks for a password for a new "Default" keyring
  - Workaround: apt -y install seahorse; open application "Passwords and Keys" and create new "Password Keyring" with name "Default" (choose any pw you like)
