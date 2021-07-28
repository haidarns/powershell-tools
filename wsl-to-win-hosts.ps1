##############################################
# PS Script to setup wsl (default) container #
# to Win 10 hosts file                       #
##############################################

###
###  Before use, please add host entry with 'wsl' domain,
###  in the end of 'C:\Windows\System32\drivers\etc\hosts' file
###  ex. :
###      12.34.56.78 wsl
###

$WSL_IP=(wsl hostname -I)

$HOST_FILE='C:\Windows\System32\drivers\etc\hosts'

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "## Setup WSL ip address to windows hosts files : ($($WSL_IP)) ##" 

    (Get-Content -path $HOST_FILE -Raw) -replace '[0-9.]+\s+wsl',"$($WSL_IP) wsl" | Out-File $HOST_FILE

    Write-Host "Finish. Press any key exit..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
else {
    Start-Process -FilePath "powershell" -ArgumentList "$('-File ""')$(Get-Location)$('\')$($MyInvocation.MyCommand.Name)$('""')" -Verb runAs
}
