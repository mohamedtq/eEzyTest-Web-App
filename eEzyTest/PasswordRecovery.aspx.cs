using MdTStudios.BusinessComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MdTStudios.eEzyTest
{
    public partial class PasswordRecovery : Page
    {
        string email;
        CodeHelper codeHelper = new CodeHelper();
        DatabaseBL objDatabaseBL = new DatabaseBL();
        DataTable dtUser = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            string key = Convert.ToString(Request.QueryString["key"]);
            if (!string.IsNullOrWhiteSpace(key))
            {
                string[] values = codeHelper.Decrypt(key).Split(new char[] { '|' });
                email = values[0].Substring(values[0].IndexOf('=') + 1);
                string token = values[1].Substring(values[1].IndexOf('=') + 1);

                dtUser = objDatabaseBL.PasswordRecovery(email, token);
                if (dtUser.Rows.Count > 0)
                {
                    errr.Style.Add("display", "none");
                    fields.Style.Add("display", "block");
                }
                else
                {
                    errr.Style.Add("display", "block");
                    errr.InnerHtml = "The link you provide may not be valid. Contact the administrator or try again.";
                    fields.Style.Add("display", "none");
                }
            }
            else Response.Redirect("Default.aspx");
        }

        protected void UpdatePassword_Click(object sender, EventArgs e)
        {
            errr.Style.Add("display", "block");

            if (password1.Text != password2.Text)
            {
                errr.InnerHtml = "Passwords didn't match!";
            }
            else
            {
                string password = codeHelper.Encrypt(password1.Text);
                dtUser = objDatabaseBL.PasswordReset(email, password);
                if (dtUser.Rows.Count > 0)
                {
                    errr.InnerHtml = "Password successfully updated. Redirecting...";
                }
                else
                {
                    errr.InnerHtml = "Something went wrong.";
                }
            }

        }
    }
}