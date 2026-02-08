using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectAppWeb
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "admin")
                Response.Redirect("Default.aspx");

        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView3.PageIndex = 0;
        }
    }
}