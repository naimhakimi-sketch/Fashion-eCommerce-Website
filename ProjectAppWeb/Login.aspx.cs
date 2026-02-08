using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ProjectAppWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string sql = @"SELECT * FROM UserAccount WHERE UserName = @username";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@username", txtUserName.Text);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                //Username found
                Object objPasswordHash = dt.Rows[0]["PasswordHash"];
                Object objRole = dt.Rows[0]["Role"];
                Object objEnabled = dt.Rows[0]["Enable"];
                string password = txtPassword.Text;
                string storedPasswordHash = objPasswordHash.ToString();
                PBKDF2Hash hash = new PBKDF2Hash(password, storedPasswordHash);
                bool check = hash.PasswordCheck;
                bool enabled = Convert.ToBoolean(objEnabled);

                if (check == true && enabled == true)
                {
                    //password correct and account enabled
                    Session["UserName"] = txtUserName.Text;
                    Session["Role"] = objRole;
                    if (Session["Role"].ToString() == "user")
                        Response.Redirect("ShopItem.aspx");
                    else if (Session["Role"].ToString() == "admin")
                        Response.Redirect("Admin.aspx");
                }
                else
                {
                    lblStatus.Text = "Status: Email or Password is incorrect!";
                }
            }
            else
            {
                lblStatus.Text = "Status: Email or Password is incorrect!";
            }
        }
    }
}