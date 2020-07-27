param ($cpzPath)

#Setup your connection details as below
$hostName = "mc4"
$programSlot = 1
$user = "admin"
$password = "password"

#You need the Crestron Powershell EDK installed
Import-Module PSCrestron

#Upload the program
Write-Host "Uploading " $cpzPath
Send-CrestronProgram -Device $hostName -LocalFile $cpzPath -ProgramSlot $programSlot -Username $user -Password $password -Secure -ShowProgress