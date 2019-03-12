using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Configuration;

namespace PasswordChangerWEB
{
  public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            var username = txtUser.Text;
            var oldPass = txtOldPass.Text;
            var newPass1 = txtNewPass1.Text;
            var newPass2 = txtNewPass2.Text;

            if (newPass1 != newPass2)
            {
                lblError.Text = "Passwords do not match";
                return;
            }

            PrincipalContext _context = null;
            try
            {
                //Get context en user object
                _context = new PrincipalContext(ContextType.Domain,
                    ConfigurationManager.AppSettings["Domain"].ToString(),
                    ConfigurationManager.AppSettings["SearchString"].ToString(),
                    ContextOptions.SecureSocketLayer | ContextOptions.Negotiate,
                    ConfigurationManager.AppSettings["Username"].ToString(),
                    ConfigurationManager.AppSettings["Password"].ToString()
                    );
                UserPrincipal user = UserPrincipal.FindByIdentity(_context, username);


                //User does not exist
                if (user == null)
                {
                    lblError.Text = "Username and/or password incorrect";
                    return;
                }

                //Check if password is expired
                bool isOldPassValid = false;

                DateTime? PasswordExpDate;
                if (user.LastPasswordSet != null)
                    PasswordExpDate = ((DateTime)user.LastPasswordSet).AddDays(int.Parse(ConfigurationManager.AppSettings["PasswordExpiresInDays"].ToString()));
                else
                    PasswordExpDate = new DateTime(1970, 01, 01);

                if ((user.LastPasswordSet == null || PasswordExpDate < DateTime.UtcNow) && !user.PasswordNeverExpires)
                {
                    //Temporarly unexpire password and check credentials
                    user.RefreshExpiredPassword();
                    isOldPassValid = _context.ValidateCredentials(user.SamAccountName, oldPass);
                    user.ExpirePasswordNow();
                }
                else
                    isOldPassValid = _context.ValidateCredentials(user.SamAccountName, oldPass);

                //Old password not correct
                if (!isOldPassValid)
                {
                    lblError.Text = "Username and/or password incorrect";
                    return;
                }

                //Everything OK, change pass
                user.SetPassword(newPass1);

                lblError.Text = "Password changed";
                txtNewPass1.Text = "";
                txtNewPass2.Text = "";
                txtOldPass.Text = "";
                txtUser.Text = "";
            }
            catch (PasswordException pex)
            {
                lblError.Text = "Password was not changed. Error:  " + pex.Message;
            }
            catch (Exception ex)
            {
                lblError.Text = string.Format("Password was not changed! Error: {0}, {1}, {2}", ex.Message, ex.StackTrace, ex.InnerException);
            }
            finally
            {
                if (_context != null)
                    _context.Dispose();
            }
        }
    }
}