using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ProjectAppWeb
{
    public partial class ShopItem : System.Web.UI.Page
    {
        static double totalAmount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null)
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
            {
                GenerateSalesId();
            }
        }

        void GenerateSalesId()
        {
            string hexTicks = DateTime.Now.Ticks.ToString("X");
            lblSalesId.Text = hexTicks.Substring(hexTicks.Length - 15, 9);
            lblDateTime.Text = DateTime.Now.ToString();
        }

        protected void GridViewItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblItemId.Text = GridViewItems.SelectedRow.Cells[1].Text;
            lblItemTitle.Text = GridViewItems.SelectedRow.Cells[2].Text;
            lblItemPrice.Text = GridViewItems.SelectedRow.Cells[3].Text;
        }

        void SalesAddItem()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesAddItem", conn);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);
            cmd.Parameters.AddWithValue("@itemid", lblItemId.Text);
            cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text);
            cmd.Parameters.AddWithValue("@User", Session["UserName"]);

            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                lblMessage1.Text = ex.Message;
            }
            finally
            {
                // Close connection
                conn.Close();
            }

            txtQuantity.Text = "1";
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewItems.PageIndex = 0;
        }

        void ClearAll()
        {
            lblItemId.Text = "";
            lblItemTitle.Text = "";
            lblItemPrice.Text = "";
            lblMessage1.Text = "";
        }

        void SalesGetTotalAmount()
        {
            // Create connection
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesGotTotalAmount", con);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                // Open connection
                con.Open();
                totalAmount = (double)cmd.ExecuteScalar();
                String totalAmountString = totalAmount.ToString();
                totalAmountString = totalAmountString.Replace("XDR", "");
                lblTotalAmountCart.Text = "RM " + totalAmountString;
            }
            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                // Close connection
                con.Close();
            }
        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            if (lblItemTitle.Text == "")
            {
                // Display a warning message in the label
                lblMessage1.Text = "Warning! You have to select an item first.";
                lblMessage1.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                SalesAddItem();
                SalesGetTotalAmount();
                Session["SalesId"] = lblSalesId.Text; // Make sure this is set after adding an item.

                // Display a success message in the label
                lblMessage1.Text = "Success! Successfully added item to cart.";
                lblMessage1.ForeColor = System.Drawing.Color.Green;

                ClearAll();
            }
        }

        protected void btnViewCart_Click(object sender, EventArgs e)
        {
            // This method will redirect the user to the SalesCart page with the current sales ID.
            Session["SalesId"] = lblSalesId.Text; // Store the current sales ID in the session.
            Response.Redirect("SalesCart.aspx"); // Redirect to the SalesCart page.
        }
    }
}
