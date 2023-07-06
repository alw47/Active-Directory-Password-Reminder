#Import AD Module
Import-Module ActiveDirectory

#Mail Server Authentication
$SecurePassword = ConvertTo-SecureString "Password for Authentication" -AsPlainText -Force
$SMTPCredential = New-Object System.Management.Automation.PSCredential ("Sender@mail.com", $SecurePassword)

#Create warning dates for future password expiration
$FourteenDaysWarnDate = (get-date).adddays(14).ToLongDateString()
$SevenDayWarnDate = (get-date).adddays(7).ToLongDateString()
$ThreeDayWarnDate = (get-date).adddays(3).ToLongDateString()

#Find accounts that are enabled and have expiring passwords
$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0 } `
 -Properties "Name", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Name", "EmailAddress", `
 @{Name = "PasswordExpiry"; Expression = {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed").tolongdatestring() }}

#Email Variables
$MailSender = "Password Change Reminder <Sender@mail.com>"
$Subject = 'Password Change Reminder - Your password will expire soon.'
$SMTPServer = 'smtp.office365.com'
$SMTPPort = '587'
$SDPhone = 'XXXX XXXX'
$SDEmail = 'example@mail.com'
$Companyname = 'Contoso'

foreach ($user in $users) {
     if ($user.PasswordExpiry -eq $FourteenDaysWarnDate) {
         $days = 14
         $Usersname = $user.name
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
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
     }
     elseif ($user.PasswordExpiry -eq $SevenDayWarnDate) {
         $days = 7
         $Usersname = $user.name
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
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
         -Body $EmailBody
     }
     elseif ($user.PasswordExpiry -eq $ThreeDayWarnDate) {
         $days = 3
         $Usersname = $user.name
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
         Send-MailMessage -To $user.EmailAddress -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody -Port $SMTPPort -Credential $SMTPCredential -BodyAsHtml -UseSsl -Encoding unicode
     }
    else {}
 }