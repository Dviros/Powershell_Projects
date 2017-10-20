$path = Split-Path -parent $PSCommandPath

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
}
