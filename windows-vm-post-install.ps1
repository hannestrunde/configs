## PowerSploit dev branch
# Redirect git stderr to stdout (https://github.com/dahlbyk/posh-git/issues/109)
$env:GIT_REDIRECT_STDERR = '2>&1'

cd $env:USERPROFILE\Tools

## Get git repos
git clone https://github.com/PowerShellMafia/PowerSploit.git
git clone -b dev https://github.com/PowerShellMafia/PowerSploit.git PowerSploit-dev
git clone https://github.com/BC-SECURITY/Empire.git
git clone https://github.com/gentilkiwi/mimikatz.git
git clone https://github.com/NetSPI/PowerUpSQL.git
git clone https://github.com/NetSPI/MicroBurst.git

## Download specific tools
Invoke-WebRequest -URI "https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.exe" -OutFile SharpHound.exe
Invoke-WebRequest -URI "https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" -OutFile SharpHound.ps1
Invoke-WebRequest -URI "https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/Certify.exe" -OutFile Certify.exe
Invoke-WebRequest -URI "https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/Rubeus.exe" -OutFile Rubeus.exe
Invoke-WebRequest -URI "https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/Seatbelt.exe" -OutFile Seatbelt.exe
Invoke-WebRequest -URI "https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/SharpDump.exe" -OutFile SharpDump.exe
Invoke-WebRequest -URI "https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.0_x64/Snaffler.exe" -OutFile Snaffler.exe
Invoke-WebRequest -URI "https://github.com/BC-SECURITY/Empire/blob/master/empire/server/data/module_source/credentials/Invoke-Mimikatz.ps1?raw=true" -OutFile Invoke-Mimikatz.ps1
Invoke-WebRequest -URI "https://github.com/skelsec/pypykatz/releases/latest/download/pypykatz.exe" -OutFile pypykatz.exe