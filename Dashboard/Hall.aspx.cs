using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace ViewMax.Dashboard
{
    public partial class Hall : System.Web.UI.Page
    {
        // Define variables to store hall properties
        protected int row;
        protected int column;
        protected string sseats;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Establish database connection
            database.dbconnection();

            // Retrieve the number of rows and columns from dropdown lists
            row = Convert.ToInt32(ddlRows.Text);
            column = Convert.ToInt32(ddlColumns.Text);

            // Hide the Panel2 control by default
            Panel2.Visible = false;

            // Bind the GridView control to a SqlDataSource control
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void BtnSub_Click(object sender, EventArgs e)
        {
            // Show the Panel1 control
            Panel1.Visible = true;

            // Retrieve input values from textboxes and dropdown lists
            string hall_name = txtHallName.Text;
            string hall_formart = txtFormart.Text;
            string Hall_seats = txtSeats.Value;
            int NoOfSeats = Convert.ToInt32(txtNoseats.Value);
            int Theatre = 0;

            // If the Session variable "Hall" is null, it means a new hall is being created
            if (Session["Hall"] == null)
            {
                Theatre = Convert.ToInt32(DropDownList1.Text);
            }

            int H_rows = Convert.ToInt32(ddlRows.Text);
            int H_cols = Convert.ToInt32(ddlColumns.Text);

            // Display the hall seats information
            Label6.Text = Hall_seats;

            // Construct SQL queries for insert and update operations
            string insert = "INSERT INTO tblHalls values('" + hall_name + "', '" + hall_formart + "','" + Theatre + "','" + H_rows + "','" + H_cols + "', @value ,'" + NoOfSeats + "')";
            string update = "UPDATE tblHalls SET Hall_Name='" + hall_name + "', Hall_Formart='" + hall_formart + "', Rows='" + H_rows + "', Cols='" + H_cols + "', SeatSpaces_1 = @value , No_of_seats='" + NoOfSeats + "' WHERE Hall_Id = '" + Session["Hall"] + "'";

            // Determine whether to insert or update the hall based on the Session variable
            if (Session["Hall"] == null)
            {
                insert_into_db(insert, Hall_seats);
            }
            else
            {
                update_db(update, Hall_seats);
            }
        }

        private void insert_into_db(string sqlText, string Hall_seats)
        {
            // Create an instance of the tblHallsTableAdapter
            onlineTableAdapters.tblHallsTableAdapter hal = new onlineTableAdapters.tblHallsTableAdapter();
            DataTable dt = new DataTable();

            // Check if the hall with the same name already exists in the theatre
            dt = hal.GetData(txtHallName.Text, Convert.ToInt32(DropDownList1.Text));

            if (dt.Rows.Count > 0)
            {
                // Display an error message if the hall already exists
                Panel1.Visible = false;
                Panel2.Visible = true;
                pnlMessage.Visible = true;
                lblTextMessage.Text = txtHallName.Text + " already exists in this theatre";
            }
            else
            {
                // Execute the
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sqlText;
                cmd.Parameters.AddWithValue("@value", Hall_seats);
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();
                Response.Redirect("~/Dashboard/Hall.aspx");
            }

            
        }

        private void update_db(string sqlText, string Hall_seats)
        {
            // Create instances of the tblHallsTableAdapter to query the database
            onlineTableAdapters.tblHallsTableAdapter hal = new onlineTableAdapters.tblHallsTableAdapter();
            onlineTableAdapters.tblHalls1TableAdapter hal1 = new onlineTableAdapters.tblHalls1TableAdapter();
            DataTable dt = new DataTable();

            // Check if the updated hall name already exists
            dt = hal1.GetData(txtHallName.Text);

            if (dt.Rows.Count > 0)
            {
                DataRow row = hal1.GetData(Session["Hall_na"].ToString())[0];

                // Get the value of a specific column in the row
                string value = row["Hall_Name"].ToString();

                if (value == txtHallName.Text)
                {
                    // Execute the SQL command to update the hall
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = sqlText;
                    cmd.Parameters.AddWithValue("@value", Hall_seats);
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();
                    Response.Redirect("~/Dashboard/Hall.aspx");
                    Session["Hall"] = null;
                }
                else
                {
                    // Display an error message if the updated hall name already exists
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    pnlMessage.Visible = true;
                    lblTextMessage.Text = "Hall title exists";
                }
            }
            else
            {
                // Execute the SQL command to update the hall
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sqlText;
                cmd.Parameters.AddWithValue("@value", Hall_seats);
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();
                Response.Redirect("~/Dashboard/Hall.aspx");
                Session["Hall"] = null;
            }
        }

        protected void ddlRows_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Update the row variable and reset the seats value
            row = Convert.ToInt32(ddlRows.Text);
            txtSeats.Value = "";
            Panel2.Visible = true;
        }

        protected void ddlColumns_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Update the column variable and reset the seats value
            column = Convert.ToInt32(ddlColumns.Text);
            txtSeats.Value = "";
            Panel2.Visible = true;
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            // Hide Panel1 and show Panel2, reset the Session variable
            Panel1.Visible = false;
            Panel2.Visible = true;
            Session["Hall"] = null;
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Change the page index of the GridView
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editt")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string v = GridView1.Rows[crow].Cells[6].Text;

                Panel1.Visible = false;
                Panel2.Visible = true;
                Session["Hall"] = v;
                Response.Write(Session["Hall"]);

                DropDownList1.Visible = false;
                ddlColumns.Visible = false;
                ddlRows.Visible = false;
                lblCols.Visible = false;
                lblRows.Visible = false;
                lblTheatr.Visible = false;

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT * FROM tblHalls WHERE Hall_Id='" + Session["Hall"].ToString() + "'";
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        txtHallName.Text = reader["Hall_Name"].ToString();
                        Session["Hall_na"] = reader["Hall_Name"].ToString();
                        txtFormart.Text = reader["Hall_Formart"].ToString();
                        txtSeats.Value = reader["SeatSpaces_1"].ToString();
                        txtNoseats.Value = reader["No_of_seats"].ToString();
                        Session["hall_thhhh"] = reader["Theatre_id"].ToString();
                        ddlColumns.Text = reader["Cols"].ToString();
                        ddlRows.Text = reader["Rows"].ToString();
                        row = Convert.ToInt32(reader["Rows"].ToString());
                        column = Convert.ToInt32(reader["Cols"].ToString());
                        sseats = reader["SeatSpaces_1"].ToString();

                    }
                }

            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Retrieve the hall ID from the selected row
            string userNameInd = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Create a SQL command to delete the hall from the database
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "DELETE FROM  tblHalls WHERE Hall_Id='" + userNameInd + "'";
            cmd.Connection = database.con;

            try
            {
                // Execute the SQL command to delete the hall
                cmd.ExecuteNonQuery();
            }
            catch (SqlException sqlEx)
            {
                Response.Write(sqlEx.Message);
            }

            // Redirect to the Hall.aspx page
            Response.Redirect("~/Dashboard/Hall.aspx");
        }
    }
}