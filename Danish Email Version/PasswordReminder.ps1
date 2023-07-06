#Import AD Module
Import-Module ActiveDirectory

#Mail Server Authentication
$SecurePassword = ConvertTo-SecureString "Password for Authentication" -AsPlainText -Force
$SMTPCredential = New-Object System.Management.Automation.PSCredential ("Sender@mail.dk", $SecurePassword)

#Create warning dates for future password expiration
$FourteenDaysWarnDate = (get-date).adddays(14).ToLongDateString()
$SevenDayWarnDate = (get-date).adddays(7).ToLongDateString()
$ThreeDayWarnDate = (get-date).adddays(3).ToLongDateString()

#Find accounts that are enabled and have expiring passwords
$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0 } `
 -Properties "Name", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Name", "EmailAddress", `
 @{Name = "PasswordExpiry"; Expression = {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed").tolongdatestring() }}

#Email Variables
$MailSender = "Password Skift påmindelse <Sender@mail.dk>"
$Subject = 'Password skift påmindelse - Dit password udløber snart'
$SMTPServer = 'smtp.office365.com'
$SMTPPort = '587'
$SDPhone = 'XXXX XXXX'
$SDEmail = 'example@mail.dk'
$Companyname = 'Contoso'

foreach ($user in $users) {
     if ($user.PasswordExpiry -eq $FourteenDaysWarnDate) {
         $days = 14
         $Usersname = $user.name
         $Emailbody = "
         <p>Hej $Usersname,</p>

         <p>Vi vil gerne informere dig om, at din adgangskode til din PC udløber om $days dage. <br>
         For at ændre din adgangskode skal du følge nedenstående instruktioner:</p>
         <ol>
             <li>Tryk Ctrl, Alt og Delete på dit tastatur.</li>
             <li>Vælg Skift adgangskode.</li>
             <li>Udfyld felterne med den gamle og nye adgangskode.</li>
         </ol>
         
         <p>Hvis du har nogen spørgsmål, kan du kontakte Servicedesk på $SDPhone eller $SDEmail.</p>
         
         Med venlig hilsen,<br> 
         $Companyname
         "
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
     }
     elseif ($user.PasswordExpiry -eq $SevenDayWarnDate) {
         $days = 7
         $Usersname = $user.name
         $Emailbody = "
         <p>Hej $Usersname,</p>

         <p>Vi vil gerne informere dig om, at din adgangskode til din PC udløber om $days dage. <br>
         For at ændre din adgangskode skal du følge nedenstående instruktioner:</p>
         <ol>
             <li>Tryk Ctrl, Alt og Delete på dit tastatur.</li>
             <li>Vælg Skift adgangskode.</li>
             <li>Udfyld felterne med den gamle og nye adgangskode.</li>
         </ol>
         
         <p>Hvis du har nogen spørgsmål, kan du kontakte Servicedesk på $SDPhone eller $SDEmail.</p>
         
         Med venlig hilsen,<br> 
         $Companyname
         "
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
         -Body $EmailBody
     }
     elseif ($user.PasswordExpiry -eq $ThreeDayWarnDate) {
         $days = 3
         $Usersname = $user.name
         $Emailbody = "
         <p>Hej $Usersname,</p>

         <p>Vi vil gerne informere dig om, at din adgangskode til din PC udløber om $days dage. <br>
         For at ændre din adgangskode skal du følge nedenstående instruktioner:</p>
         <ol>
             <li>Tryk Ctrl, Alt og Delete på dit tastatur.</li>
             <li>Vælg Skift adgangskode.</li>
             <li>Udfyld felterne med den gamle og nye adgangskode.</li>
         </ol>
         
         <p>Hvis du har nogen spørgsmål, kan du kontakte Servicedesk på $SDPhone eller $SDEmail.</p>
         
         Med venlig hilsen,<br> 
         $Companyname
         "
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
     }
    else {}
 }