using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using ViewMax.Dashboard;

namespace ViewMax
{
    public partial class createu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Establish a database connection
            database.dbconnection();

            // Hide the profile picture panel initially
            pnl_pfp.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Retrieve user input values
            string username = txtUserName.Text;
            string f_name = txtFName.Text;
            string l_name = txtLName.Text;
            string email = txtEmail.Text;
            string password = txtPass.Text;
            string poster_path = "";

            // Create instances of the table adapters
            LoginTableAdapters.tblAdminUserNameTableAdapter tblAdminUser = new LoginTableAdapters.tblAdminUserNameTableAdapter();
            LoginTableAdapters.tblAdminEmailTableAdapter tblAdminEmail = new LoginTableAdapters.tblAdminEmailTableAdapter();
            LoginTableAdapters.tblUserUserNameTableAdapter tblUserUserName = new LoginTableAdapters.tblUserUserNameTableAdapter();
            LoginTableAdapters.tblUsersEmailTableAdapter tblUsersEmail = new LoginTableAdapters.tblUsersEmailTableAdapter();

            // Create data tables to store the retrieved data
            DataTable dtA_user = new DataTable();
            DataTable dtA_Email = new DataTable();
            DataTable dtU_user = new DataTable();
            DataTable dtU_Email = new DataTable();

            // Retrieve data from the admin user table using the provided username
            dtA_user = tblAdminUser.GetData(txtUserName.Text);

            // Retrieve data from the admin email table using the provided email
            dtA_Email = tblAdminEmail.GetData(txtEmail.Text);

            // Retrieve data from the user username table using the provided username
            dtU_user = tblUserUserName.GetData(txtUserName.Text);

            // Retrieve data from the user email table using the provided email
            dtU_Email = tblUsersEmail.GetData(txtEmail.Text);

            // Check if the username exists in either the admin or user tables
            if (dtA_user.Rows.Count > 0 || dtU_user.Rows.Count > 0)
            {
                pnl_error.Visible = true;
                lblError.Text = "Username Exists";
            }
            else
            {
                // Check if the email exists in either the admin or user tables
                if (dtA_Email.Rows.Count > 0 || dtU_Email.Rows.Count > 0)
                {
                    pnl_error.Visible = true;
                    lblError.Text = "Email Exists";
                }
                else
                {
                    // Construct the SQL query to insert the user into the tblUsers table
                    string sqlText = "INSERT INTO tblUsers values('" + username + "', '" + f_name + "', '" + l_name + "', '" + email + "','" + password + "', '" + poster_path + "')";

                    // Create a SqlCommand object and set its properties
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = sqlText;
                    cmd.Connection = database.con;

                    // Execute the SQL query
                    cmd.ExecuteNonQuery();

                    // Hide the sign-up panel and show the profile picture panel
                    SignUp_Panel.Visible = false;
                    pnl_pfp.Visible = true;
                }
            }
        }

        protected void Addprofile_Click(object sender, EventArgs e)
        {
            string pfpn = pfp.PostedFile.FileName;
            string sqlText = "UPDATE  tblUsers SET Poster_path = @value WHERE User_Name = '"+txtUserName.Text+"'";

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = sqlText;
            cmd.Parameters.AddWithValue("@value", pfpn);
            cmd.Connection = database.con;
            cmd.ExecuteNonQuery();

            Response.Redirect("LoginU.aspx");
        }
    }
}