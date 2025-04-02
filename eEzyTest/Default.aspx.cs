using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using MdTStudios.BusinessComponent;
using MdTStudios.DatabaseLayer;
using System.Data;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Diagnostics;

namespace MdTStudios.eEzyTest
{
    public partial class Default : System.Web.UI.Page
    {
        CodeHelper codeHelper = new CodeHelper();
        DatabaseBL objDatabaseBL = new DatabaseBL();
        DataTable dtUser = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            try
            {
                String LoginType = "", ClickPurpose = LoginPurpose.Value;

                if (ClickPurpose != "Forgot")
                {
                    if (Regex.IsMatch(txtUsername.Text, "[0-9]{10,}")) LoginType = "mobile";
                    else if (txtUsername.Text.Contains('@') && txtUsername.Text.Contains('.')) LoginType = "email";
                    else LoginType = "username";

                    dtUser = objDatabaseBL.LoginValidate(txtUsername.Text, codeHelper.Encrypt(txtPassword.Text), LoginType);

                    if (dtUser.Rows.Count > 0)
                    {
                        Session["FirstName"] = dtUser.Rows[0]["UserFirstName"];
                        Response.Redirect("HomeScreen.aspx");
                    }
                    else
                    {
                        errorlabel.Style.Add("display", "block");
                        errordiv.Style.Add("display", "block");
                        errorlabel.InnerHtml = "Invalid credentials!";
                    }
                }
                else
                {
                    string token = codeHelper.CreateToken();
                    dtUser = objDatabaseBL.ForgotPassword(txtUsername.Text, token);

                    if (dtUser.Rows.Count > 0)
                    {
                        string link = "http://localhost:65138/PasswordRecovery.aspx?key=" + codeHelper.Encrypt("email=" + txtUsername.Text + "|token=" + token);
                        Debug.WriteLine(link);
                        //SendPasswordToEmail(txtUsername.Text, link);
                        errorlabel.Style.Add("display", "block");
                        errordiv.Style.Add("display", "block");
                        errorlabel.InnerHtml = "We just emailed your password.";
                    }
                    else
                    {
                        errorlabel.Style.Add("display", "block");
                        errordiv.Style.Add("display", "block");
                        errorlabel.InnerHtml = "This email address isn't registered.";
                    }
                    ClientScript.RegisterHiddenField("isPostBack", "Forgot");
                }
            }
            catch
            {
                errorlabel.Style.Add("display", "block");
                errordiv.Style.Add("display", "block");
                errorlabel.InnerHtml = "There's something wrong :-(";
            }
        }

        private void SendPasswordToEmail(string Email, string link)
        {
            SmtpClient smtpClient = new SmtpClient("mySMTPDomain", 25);

            smtpClient.Credentials = new System.Net.NetworkCredential("myemailaddrss", "mypassword");
            smtpClient.UseDefaultCredentials = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.EnableSsl = true;
            MailMessage mail = new MailMessage();

            mail.From = new MailAddress("noreply@eezytest.com", "eEzyTest Password Recovery");
            mail.To.Add(new MailAddress(Email));
            mail.Body = link;

            smtpClient.Send(mail);
        }

    }
}