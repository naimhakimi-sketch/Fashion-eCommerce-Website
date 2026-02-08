using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace ProjectAppWeb
{
    public partial class SalesCart : System.Web.UI.Page
    {
        static double totalAmount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SalesId"] != null)
                {
                    lblSalesId.Text = Session["SalesId"].ToString();
                    lblDateTime.Text = DateTime.Now.ToString();
                    SalesGetTotalAmount(); // Calculate the total amount when the page loads.
                    GridViewCart.DataBind(); // Bind the GridView for the cart.
                }
                else
                {
                    // Redirect to the shop item page or show an error message if no sales ID is present.
                    Response.Redirect("ShopItem.aspx");
                }
            }
        }

        void SalesGetTotalAmount()
        {
            // Create connection
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesGotTotalAmount", con)
            {
                // Set command object for stored procedure execution
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                // Open connection
                con.Open();
                totalAmount = (double)cmd.ExecuteScalar();
                String totalAmountString=totalAmount.ToString();
                totalAmountString.Replace("XDR", "");
                lblTotalAmountCart.Text = "RM" + totalAmountString;
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

        void SalesRemoveNotConfirmed()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesRemoveNotConfirm", conn);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }

        void ClearAll()
        {

            lblTotalAmountCart.Text = "RM0.00";
            lblTotalAmount.Text = "";
            lblServiceTax.Text = "";
            lblAmountAfterTax.Text = "";
            lblRounding.Text = "";
            lblAmountRounded.Text = "";
            lblMessage2.Text = "";
        }

        void SalesConfirm()
        {
            // Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);

            // Create command object with Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesConfirm", conn);

            // Set command object for stored procedure execution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                // Open connection
                conn.Open();
                cmd.ExecuteNonQuery();
                lblMessage2.Text = "Sales confirmed!";
            }
            catch (SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                // Close connection
                conn.Close();
            }

        }
        void DisplayInvoice()
        {
            double serviceTax, amountAfterTax, amountRounded, rounding;
            serviceTax = totalAmount * 0.06;
            amountAfterTax = totalAmount + serviceTax;
            amountRounded = Math.Round((amountAfterTax / 0.05)) * 0.05;
            rounding = amountRounded - amountAfterTax;

            lblTotalAmount.Text = "Total amount: RM" + totalAmount.ToString("F2");
            lblServiceTax.Text = "Service tax (6%): RM" + serviceTax.ToString("F2");
            lblAmountAfterTax.Text = "Amount after tax: RM" + amountAfterTax.ToString("F2");
            lblRounding.Text = "Rounding: RM" + rounding.ToString("F2");
            lblAmountRounded.Text = "Amount to pay: RM" + amountRounded.ToString("F2");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            SalesConfirm();
            DisplayInvoice();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ClearAll();
            Response.Redirect("ShopItem.aspx"); 

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            SalesRemoveNotConfirmed();
            ClearAll();
            Response.Redirect("ShopItem.aspx"); 
        }

    }
    
}