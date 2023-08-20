using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;


namespace ViewMax.Dashboard
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            database.dbconnection();
           
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();

        }

        protected void Add_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        protected void lkbAddAdmin_Click(object sender, EventArgs e)
        {
            //Declare variables
            string image_path = pfp.PostedFile.FileName;
            string image_Extension = System.IO.Path.GetExtension(pfp.PostedFile.FileName);

            string first_name = txtFirstName.Text;
            string last_name = txtLastName.Text;
            string userName = txtUserName.Text;
            string email = txtEmail.Text;
            int gender = 0;

            Random random = new Random();
            int randomNumber = random.Next(0, 1000);

            string image_name = "";
            //Give our image a unique name

            if (pfp.HasFile)
            {
                image_name = userName + "_" + randomNumber.ToString() + "_" + image_Extension;
                pfp.SaveAs(Request.PhysicalApplicationPath + "/Dashboard/pfp_images/" + image_name);

                if (Session["Username"] != null)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "SELECT * FROM tblAdmin WHERE username='" + Session["Username"].ToString() + "'";
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string r_image_name = reader["image_path"].ToString();

                            if(r_image_name != image_name)
                            {
                                string pfp_path = Server.MapPath("/Dashboard/pfp_images/" + r_image_name);
                                FileInfo file = new FileInfo(pfp_path);
                                if (file.Exists)
                                {
                                    file.Delete();
                                }
                            }

                        }

                    }
                }
                
            }
            else
            {
                if (Session["Username"] != null)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "SELECT * FROM tblAdmin WHERE username='" + Session["Username"].ToString() + "'";
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            image_name = reader["image_path"].ToString();

                        }

                    }
                }

            }

            if (RadioButton1.Checked == true)
            {
                gender = 1;
            }
            else if(RadioButton2.Checked == true)
            {
                gender = 0;
            }
            string password = txtPass.Text;

            string x = "xvvv";

            string insert = "INSERT INTO tblAdmin values('" + first_name + "','" + last_name + "','" + userName + "','" + email + "','" + gender + "','" + password + "','" + image_name + "')";
            string update = "UPDATE tblAdmin SET First_Name ='"+ first_name + "', Last_Name ='"+ last_name + "', Gender ='"+ gender + "', Password ='"+ password + "', image_path ='"+ image_name + "'  WHERE Username= '" + Session["Username"] + "' ";

            if (Session["Username"] == null)
            {
                Insert_To_Db(insert);
            }
            else
            {
                Upadate_To_Db(update);
                Session["username"] = null;
            }
            
        }

        private void Insert_To_Db(string sqlText)
        {
            ///
            /// 
            ///

            onlineTableAdapters.tblAdminUsernameTableAdapter adminUserName = new onlineTableAdapters.tblAdminUsernameTableAdapter();
            onlineTableAdapters.tblAdminEmailTableAdapter adminEmail = new onlineTableAdapters.tblAdminEmailTableAdapter();
            DataTable dataTableUserName = new DataTable();
            DataTable dataTableEmail = new DataTable();
            dataTableUserName = adminUserName.GetData(txtUserName.Text);
            dataTableEmail = adminEmail.GetData(txtEmail.Text);
            if (dataTableUserName.Rows.Count > 0)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
                pnlMessage.Visible = true;
                lblTextMessage.Text = "User name is already in use";
            }
            else
            {
                if(dataTableEmail.Rows.Count > 0)
                {
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    pnlMessage.Visible = true;
                    lblTextMessage.Text = "Email already in use";
                }
                else
                {
                    //connection to the data base
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = sqlText;
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();

                    Response.Redirect("~/Dashboard/admin.aspx");
                }
                
            }


        }

        private void Upadate_To_Db(string sqlText)
        {
            ///
            /// 
            ///

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = sqlText;
            cmd.Connection = database.con;
            cmd.ExecuteNonQuery();
            Response.Redirect("~/Dashboard/admin.aspx");


        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string userNameInd = GridView1.DataKeys[e.RowIndex].Value.ToString();
            //connection to the data base
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "DELETE FROM  tblAdmin WHERE username='" + userNameInd + "'";
            cmd.Connection = database.con;
            cmd.ExecuteNonQuery();

            Response.Redirect("~/Dashboard/admin.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Editt")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string v = GridView1.Rows[crow].Cells[1].Text;

                Panel1.Visible = false;
                Panel2.Visible = true;
                Session["username"] = v;

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT * FROM tblAdmin WHERE username='" + Session["Username"].ToString() + "'";
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        txtFirstName.Text = reader["First_Name"].ToString();
                        txtLastName.Text = reader["Last_Name"].ToString();
                        txtUserName.Text = reader["Username"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtUserName.Visible = false;
                        txtEmail.Visible = false;
                        Lbluser.Visible = false;
                        lblemail.Visible = false;
                        RequiredFieldValidator2.Visible = false;
                        RequiredFieldValidator5.Visible = false;
                        RegularExpressionValidator1.Visible = false;
                        txtCpass.Text = reader["Password"].ToString();
                        string imagess = reader["Image_path"].ToString();
                        Image1.ImageUrl = "~/Dashboard/pfp_images/" + imagess;
                        int gender = Convert.ToInt32(reader["Gender"].ToString());
                        if (gender == 0)
                        {
                            RadioButton1.Checked = false;
                            RadioButton2.Checked = true;
                        }

                    }
                }

            }
        }
    }
}