#Email variables
$SecurePassword = ConvertTo-SecureString "Password for Authentication" -AsPlainText -Force
$SMTPCredential = New-Object System.Management.Automation.PSCredential ("Sender@mail.com", $SecurePassword)
$MailSender = "Password Change Reminder <Sender@mail.com>"
$Subject = 'Password Change Reminder - Your password will expire soon.'
$SMTPServer = 'smtp.office365.com'
$SMTPPort = '587'
$days = '7'
$Usersname = 'Test User'
$TestRecipient = 'Youremail@mail.com'
$Companyname = 'Contoso'

$Emailbody = "
<p>Dear $Usersname,</p>

<p>We would like to inform you that your password for your PC will expire in $days days. <br>
To change your password, please follow the instructions below:</p>
<ol>
    <li>Press Ctrl, Alt, and Delete on your keyboard.</li>
    <li>Select Change Password.</li>
    <li>Fill in the fields with the old and new passwords.</li>
</ol>

<p>If you have any questions, please contact the ServiceDesk at $SDPhone or $SDEmail.</p>

Best regards,<br> 
$Companyname
"
Send-MailMessage -To $TestRecipient -From $MailSender -SmtpServer $SMTPServer -Port $SMTPPort -Credential $SMTPCredential -UseSsl -Subject $Subject -BodyAsHtml -Body $Emailbody -Encoding unicode