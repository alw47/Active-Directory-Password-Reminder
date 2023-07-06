# Active Directory Password Reminder
This script is designed to be set up as a scheduled task on a server within an Active Directory environment.
It searches the Active Directory for users and sends email reminders to those whose passwords will expire in 3, 7, or 14 days.

## How to Use

### Fill out the variables for SMTP authentication:

* $SecurePassword
* $SMTPCredential

### Fill out the variables for Email settings:

* $MailSender
* $Subject
* $SMTPServer
* $SMTPPort
* $SDPhone
* $SDEmail
* $Companyname

Make sure to provide the necessary information and customize the variables according to your specific setup and preferences.
Please note that this script assumes you have a functioning SMTP server configured to send out emails.
