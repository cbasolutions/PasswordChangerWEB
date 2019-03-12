# Active Directory Password Change Web/IIS

### Current Version Notes:
#### Release - 2019-03-12
#### Version .1
#### Source of original version - https://www.tuser.nl/software/active-directory-password-change-webiis/

The following simple website/tool allows a user to change her or his password even when the password is expired or when the administrator enabled “change on next logon”. This is a replacement for the IISADMPWD. You need .net 4.0 and IIS to run this. I use this website at a client i work for who has federated users in office 365. In this case, it is not possible to change a password via portal.microsoftonline.com. I also wrote a powershell script which sends an email every day to every user which has a password which is about to expire. In the email i include the link to this website.

Configuration can be done via web.config and needs 5 settings:

* Domain: internal domain name of the Active Directory
* SearchString: Where to look for the users
* Username: Username with permissions to set, expire and unexpire user passwords
* Password: Password for this user
* PasswordExpiresInDays: Provide in how many days the password expires in AD. Used to calculate if the user password is expired.

![Screenshot](https://raw.githubusercontent.com/cbasolutions/PasswordChangerWEB/master/screenshot.png)
