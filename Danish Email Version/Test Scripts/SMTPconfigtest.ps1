#Email variables
$SecurePassword = ConvertTo-SecureString "Password for Authentication" -AsPlainText -Force
$SMTPCredential = New-Object System.Management.Automation.PSCredential ("Sender@mail.dk", $SecurePassword)
$MailSender = "Password Skift påmindelse <Sender@mail.dk>"
$Subject = 'Password skift påmindelse - Dit password udløber snart'
$SMTPServer = 'smtp.office365.com'
$SMTPPort = '587'
$days = '7'
$Usersname = 'Test User'
$TestRecipient = 'Youremail@mail.dk'
$Companyname = 'Contoso'

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
Send-MailMessage -To $TestRecipient -From $MailSender -SmtpServer $SMTPServer -Port $SMTPPort -Credential $SMTPCredential -UseSsl -Subject $Subject -BodyAsHtml -Body $Emailbody -Encoding unicode