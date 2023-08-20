using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace ViewMax.Dashboard
{
    public partial class theatre : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel2.Visible=false;
            database.dbconnection();

            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Session["Theatre"] = null;
            Panel1.Visible = false;
            Panel2.Visible = true;
        }
        protected void btnSubmi_Click(object sender, EventArgs e)
        {
            string theatre_name = txtTheatre.Text;
            string location = txtThLoc.Text;

            string insert = "INSERT INTO tblTheatre values('" + theatre_name + "', '" + location + " ')";
            string update = "UPDATE tblTheatre SET Theatre_Name='" + theatre_name + "', Theatre_Location='" + location + " ' WHERE Theatre_Name ='" + Session["Theatre"] + "' ";

            if (Session["Theatre"] == null )
            {
                insert_to_db(insert);
            }
            else
            {
                update_db(update);
            }
            
        }

        protected void insert_to_db(string sqlText)
        {
            onlineTableAdapters.tblTheatreTableAdapter thert = new onlineTableAdapters.tblTheatreTableAdapter();
            DataTable dt = new DataTable();
            dt = thert.GetData(txtTheatre.Text);
            if (dt.Rows.Count > 0)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
                pnlMessage.Visible = true;
                lblTextMessage.Text = "Theatre already exists";
            }
            else
            {

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sqlText;
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();
                Response.Redirect("~/Dashboard/Theatre.aspx");
            }

        }

        protected void update_db(string sqlText)
        {
            onlineTableAdapters.tblTheatreTableAdapter thert = new onlineTableAdapters.tblTheatreTableAdapter();
            DataTable dt = new DataTable();
            dt = thert.GetData(txtTheatre.Text);
            if (dt.Rows.Count > 0)
            {
                string select = "SELECT * FROM tblTheatre WHERE Theatre_Name='" + Session["Theatre"].ToString() + "'";

                DataRow row = thert.GetData(Session["Theatre"].ToString())[0];

                // Get the value of a specific column in the row
                string value = row["Theatre_Name"].ToString();

                if (value == txtTheatre.Text)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = sqlText;
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();
                    Response.Redirect("~/Dashboard/theatre.aspx");
                }
                else
                {
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    pnlMessage.Visible = true;
                    lblTextMessage.Text = "Theatre title exists";
                }
            }
            else
            {

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = sqlText;
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();
                Response.Redirect("~/Dashboard/Theatre.aspx");
            }

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editt")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string v = GridView1.Rows[crow].Cells[1].Text;

                Panel1.Visible = false;
                Panel2.Visible = true;
                Session["Theatre"] = v;

                string select = "SELECT * FROM tblTheatre WHERE Theatre_Name='" + Session["Theatre"].ToString() + "'";

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = select;
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        txtTheatre.Text = reader["Theatre_Name"].ToString();
                        txtThLoc.Text = reader["Theatre_Location"].ToString();
                        
                    }
                }
            }

            if(e.CommandName == "Delett")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string th_id = GridView1.Rows[crow].Cells[5].Text;
                string th_name = GridView1.Rows[crow].Cells[1].Text;

                 string del = "DELETE FROM  tblTheatre WHERE Theatre_Name='" + th_name + "'";
                 string del_hall = "DELETE FROM  tblHalls WHERE Theatre_id='" + th_id + "'";

                 SqlCommand cmd = new SqlCommand();
                 cmd.CommandText = del;
                 cmd.CommandText = del_hall;
                 cmd.Connection = database.con;
                 cmd.ExecuteNonQuery();
                 Response.Redirect("~/Dashboard/Theatre.aspx");
            }
        }
    }
}