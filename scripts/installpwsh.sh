wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-arm64.tar.gz
# tar xzf powershell-7.3.7-linux-arm64.tar.gz
# ls
sudo mkdir -p /opt/microsoft/powershell/7
sudo tar zxf powershell-7.3.7-linux-arm64.tar.gz -C /opt/microsoft/powershell/7/
rm -f powershell-7.3.7-linux-arm64.tar.gz
sudo chmod +x /opt/microsoft/powershell/7/pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
# pwsh