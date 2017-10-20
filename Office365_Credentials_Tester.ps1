# Needed variables:
############################################################################

$path = Split-Path -parent $PSCommandPath
$list = ''


if (Get-Content $path\credentials.txt){
    Write-Host "Credentials.txt was found, we can continue."
    Write-Host "##################### Step 1. ####################" -BackgroundColor DarkGreen
    Write-Host "############# Office 365 Validation ##############" -BackgroundColor DarkGreen
    foreach($line in Get-Content $path\credentials.txt) {
        if($line){
            $UserName = ($line -split ':')[0]
            $Password = ($line -split ':')[-1]
            $securedpass = $Password | ConvertTo-SecureString -AsPlainText -Force
            $Cred = New-Object System.Management.Automation.PsCredential($UserName,$securedpass)

            try{
                $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Cred -Authentication Basic -AllowRedirection -ErrorAction Ignore
                if ($Session){
                    Write-Host "Valid Credentials For" $UserName -BackgroundColor Blue
                    Remove-PSSession $Session
                    $list = $UserName + " (Office 365)" + ", " + $list
                }
                else{
                    throw
                }
            }
            catch{
                Write-Host "Invalid Credentials For" $UserName -BackgroundColor Red
                continue
            }
        }
        else {
            Write-Host "The file is empty, please add data - username:password."
            }
    }
    if ($list){
        Write-Host " "
        Write-Host "These are the credential that were valid:"
        Write-Host $list
    }
    else {
        Write-Host "No valid credentials have been found."
        }
}

else{
    Write-Host "Credentials.txt wasn't found. Verify and exists and run the script again"
    }
