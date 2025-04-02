using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using MdTStudios.DatabaseLayer;

namespace MdTStudios.BusinessComponent
{
    public class DatabaseBL
    {
        public DataTable LoginValidate(string strUsername, string strPassword, string strLoginType)
        {
            Hashtable htLogin = new Hashtable();
            htLogin.Add("@UserName", strUsername);
            htLogin.Add("@UserPassword", strPassword);
            htLogin.Add("@LoginType", strLoginType);
            return DataProxy.FetchDataTable("EZY_LoginValidate", htLogin);
        }

        public DataTable ForgotPassword(string strEmail, string strToken)
        {
            Hashtable htForgot = new Hashtable();
            htForgot.Add("@Email", strEmail);
            htForgot.Add("@Token", strToken);
            return DataProxy.FetchDataTable("EZY_ForgetPassword", htForgot);
        }

        public DataTable PasswordRecovery(string strEmail, string strToken)
        {
            Hashtable htRecovery = new Hashtable();
            htRecovery.Add("@Email", strEmail);
            htRecovery.Add("@Token", strToken);
            return DataProxy.FetchDataTable("EZY_PasswordRecovery", htRecovery);
        }

        public DataTable PasswordReset(string strEmail, string strPassword)
        {
            Hashtable htReset = new Hashtable();
            htReset.Add("@Email", strEmail);
            htReset.Add("@Password", strPassword);
            return DataProxy.FetchDataTable("EZY_PasswordReset", htReset);
        }

        public DataTable GetUser(string strUserType)
        {
            Hashtable htGetUser = new Hashtable();
            htGetUser.Add("@UserType", strUserType);
            return DataProxy.FetchDataTable("EZY_GetUser", htGetUser);
        }

    }
}
