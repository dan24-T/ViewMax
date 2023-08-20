using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax.Dashboard
{
    public partial class Show : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            database.dbconnection();
            var date = DateTime.Now.AddDays(5);
            string start_show_date = date.ToString();
            Session["v_date"] = start_show_date;

            Panel2.Visible = false;

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string show_date = txtShowDate.Text;
            string end_date = txtSEndDate.Text;
            string start_time = txtStart_Time.Text;
            string end_time = txtEnd_Time.Text;
            int movie = Convert.ToInt32(ddlMovie_Name.Text);
            int hall = Convert.ToInt32(ddlHall_Name.Text);

            string insert = "INSERT INTO tblShow values('"+ show_date +"','"+ start_time +"','"+ end_time +"','"+ movie +"','"+ hall +"','"+ end_date +"')";
            string update_movie = "UPDATE tblMovies SET Showing ='" + 1 + "' WHERE movie_Id='"+movie+"'";
            insert_in_db(insert, update_movie);

        }

        private void insert_in_db(string sqlText, string updSqlText)
        {
            onlineTableAdapters.tblShowTableAdapter adpl = new onlineTableAdapters.tblShowTableAdapter();
            DataTable dt = new DataTable();
            dt = adpl.GetData(Convert.ToInt32(ddlHall_Name.Text), txtShowDate.Text, txtShowDate.Text);
            if (dt.Rows.Count > 0)
            {
                pnlMessage.Visible = true;
                pnlMessage.BackColor = System.Drawing.Color.Pink;
                lblTextMessage.Text = "The hall is in use in the selected date ";
                Panel2.Visible = true;
                Panel1.Visible = false;
            }
            else
            {
                pnlMessage.Visible = true;
                pnlMessage.BackColor = System.Drawing.Color.AliceBlue;
                lblTextMessage.Text = "dates are valid";

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sqlText;
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();
                SqlCommand upd = new SqlCommand();
                upd.CommandText = updSqlText;
                upd.Connection = database.con;
                upd.ExecuteNonQuery();

                Response.Redirect("~/Dashboard/Show.aspx");
            }
            
        }

        protected void txtEnd_Time_TextChanged(object sender, EventArgs e)
        {
            if(Convert.ToDateTime(txtStart_Time.Text) > Convert.ToDateTime(txtEnd_Time.Text) )
            {
                pnlMessage.Visible = true;
                lblTextMessage.Text = "End time needs to be greater than start time";
            }
            else
            {
                pnlMessage.Visible = true;
                pnlMessage.BackColor = System.Drawing.Color.AliceBlue;
                lblTextMessage.Text = "time is valid";
            }

            Panel2.Visible = true;
            Panel1.Visible = false;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int theatre_id = Convert.ToInt32(DropDownList1.SelectedValue);
            Session["the_id"] = theatre_id;
            Panel2.Visible = true;
            Panel1.Visible = false;
        }

        protected void txtSEndDate_TextChanged(object sender, EventArgs e)
        {
            if (Convert.ToDateTime(txtShowDate.Text) > Convert.ToDateTime(txtSEndDate.Text))
            {
                pnlMessage.Visible = true;
                pnlMessage.BackColor = System.Drawing.Color.Pink;
                pnlMessage.ForeColor = System.Drawing.Color.Red;
                lblTextMessage.Text = "End date cannot to be greater than start Date";
            }
            else
            {
                pnlMessage.Visible = true;
                pnlMessage.BackColor = System.Drawing.Color.AliceBlue;
                pnlMessage.ForeColor = System.Drawing.Color.Green;
                lblTextMessage.Text = "valid Dates";
            }
            Panel2.Visible = true;
            Panel1.Visible = false;
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string show_Id = GridView1.DataKeys[e.RowIndex].Values["Show_Id"].ToString();
            int movie_Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["movie_Id"].ToString());
            //connection to the data base

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "DELETE FROM  tblShow WHERE Show_id='" + show_Id + "'";
            cmd.Connection = database.con;
            cmd.ExecuteNonQuery();

            onlineTableAdapters.tblShow1TableAdapter rm_movie = new onlineTableAdapters.tblShow1TableAdapter();
            DataTable dt = new DataTable();
            dt = rm_movie.GetData(movie_Id);

            if (dt.Rows.Count > 0)
            {
                string update_movie = "UPDATE tblMovies SET Showing ='" + 1 + "' WHERE movie_Id='" + movie_Id + "'";
                SqlCommand up_cmd = new SqlCommand();
                up_cmd.CommandText = update_movie;
                up_cmd.Connection = database.con;
                up_cmd.ExecuteNonQuery();
            }
            else {
                string update_movie = "UPDATE tblMovies SET Showing ='" + 0 + "' WHERE movie_Id='" + movie_Id + "'";
                SqlCommand up_cmd = new SqlCommand();
                up_cmd.CommandText = update_movie;
                up_cmd.Connection = database.con;
                up_cmd.ExecuteNonQuery();
            }

            Response.Redirect("~/Dashboard/Show.aspx");
        }

        protected void lkbShow_movie_Click(object sender, EventArgs e)
        {
            Panel2.Visible = true;
            Panel1.Visible = false;
        }
    }
}