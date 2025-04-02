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
    public partial class HomeScreen : System.Web.UI.Page
    {
        DatabaseBL objDatabaseBL = new DatabaseBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FirstName"] != null)
            {
                if (!IsPostBack)
                {
                    lblShow.Text = "Hi " + Session["FirstName"].ToString();
                    GetUsersFromTable();
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        private void GetUsersFromTable()
        {
            DataTable dtStores = new DataTable();
            dtStores = objDatabaseBL.GetUser("");

            gvUsersTable.DataSource = dtStores;
            gvUsersTable.DataBind();
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}