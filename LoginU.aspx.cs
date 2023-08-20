using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax
{
    public partial class LoginU : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Reset the session level
            Session["level"] = null;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Create instances of the table adapters
            LoginTableAdapters.tblAdminTableAdapter tblAdmin = new LoginTableAdapters.tblAdminTableAdapter();
            LoginTableAdapters.tblUsersTableAdapter tblUsers = new LoginTableAdapters.tblUsersTableAdapter();

            // Create data tables to store the retrieved data
            DataTable dtA = new DataTable();
            DataTable dtU = new DataTable();

            // Retrieve data from the admin table using the provided username and password
            dtA = tblAdmin.GetData(txtUsername.Text, txtPassword.Text);

            // Retrieve data from the users table using the provided username and password
            dtU = tblUsers.GetData(txtUsername.Text, txtPassword.Text);

            // Check if the admin table returned any rows
            if (dtA.Rows.Count > 0)
            {
                // Set the session level to "1" to indicate admin access
                Session["level"] = "1";
                Session["name"] = txtUsername.Text;
                Response.Redirect("HomePage.aspx");
            }
            // Check if the users table returned any rows
            else if (dtU.Rows.Count > 0)
            {
                // Set the session level to "0" to indicate user access
                Session["level"] = "0";
                Session["name"] = txtUsername.Text;
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                // Display an error message for invalid username/password
                pnl_error.Visible = true;
                lblError.Text = "Invalid Username/password";
            }
        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            // Redirect to the createu.aspx page for user sign-up
            Response.Redirect("createu.aspx");
        }
    }
}
