## PowerSploit dev branch
# Redirect git stderr to stdout (https://github.com/dahlbyk/posh-git/issues/109)
$env:GIT_REDIRECT_STDERR = '2>&1'

cd c:\Tools
git clone -b dev https://github.com/PowerShellMafia/PowerSploit.git PowerSploit-dev
