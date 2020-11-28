# Description
## win10-preset.txt
A custom preset file to use with https://github.com/Disassembler0/Win10-Initial-Setup-Script/

# Todo
## kali-post-install.zsh
- [ ] Add printerbug.py (krbrelayx repo from dirkjanm)
- [ ] Add https://github.com/dirkjanm/PrivExchange
- [ ] Add zerologon_tester.py
- [ ] install_bloodhound (): add neo4j Config to repo and download and replace (Listening on 0.0.0.0)
- [ ] install_lsassy (): Download procdump to /root/tools/procdump
- [ ] Add pypykatz
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
