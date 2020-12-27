#PowerShell functions that I have found useful


# This function is meant for quiet software installs and uninstalls on remote workstations via UNC path.
# To my knowledge, this solves double-hop authentication issue, but not guaranteed to be a secure method.

function softwareInstall {
$computer = Read-Host Enter target workstation
$user = Read-Host Enter username e.g. domain\user
$pword = Read-Host Enter password -AsSecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pword
$sess = New-PSSession -ComputerName $computer -Credential $cred
Invoke-Command -Session $sess -ScriptBlock {New-PSDrive -Name T -PSProvider FileSystem -Root \\Servername\Path -Credential $using:cred -Persist
Start-Process '\\Servername\Path to executable' /quiet}
}
