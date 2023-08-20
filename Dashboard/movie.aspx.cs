using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace ViewMax.Dashboard
{
    public partial class movie : System.Web.UI.Page
    {
        protected string u_date;
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            database.dbconnection();

            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void lkbAddMovie_Click(object sender, EventArgs e)
        {
            Session["Movie_title"] = null;
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        protected void btnSubmitMovie_Click(object sender, EventArgs e)
        {
            string poster_Extension = System.IO.Path.GetExtension(poster.PostedFile.FileName);
            string movie_name = txtMovieTitle.Text;
            string movie_link = txtMovieLink.Text;
            string genre = ddlGenre.Text;
            string movie_duration = txtDuration.Text;
            string movie_release = txtReleaseDate.Text;
            string description = txtDescription.Text;
            string poster_name = "";
            int showing = 0;

            Random random = new Random();
            int randomNumber = random.Next(0, 1000);

            if (poster.HasFile)
            {
                poster_name = movie_name + "_" + randomNumber.ToString() + "_" + poster_Extension;
                poster.SaveAs(Request.PhysicalApplicationPath + "/Dashboard/poster_images/" + poster_name);

                if (Session["Movie_title"] != null)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "SELECT * FROM tblMovies WHERE Movie_title='" + Session["Movie_title"].ToString() + "'";
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string r_poster_name = reader["Poster_path"].ToString();

                            if (r_poster_name != poster_name)
                            {
                                string pfp_path = Server.MapPath("/Dashboard/poster_images/" + r_poster_name);
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
                if (Session["Movie_title"] != null)
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "SELECT * FROM tblMovies WHERE Movie_title='" + Session["Movie_title"].ToString() + "'";
                    cmd.Connection = database.con;
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            poster_name = reader["Poster_path"].ToString();

                        }

                    }
                }
            }




            string insert = "INSERT INTO tblMovies values('" + movie_name + "','" + movie_link + "','" + genre + "','" + movie_release + "','" + description + "','" + poster_name + "','" + movie_duration + "','"+showing+"')";
            string update = "UPDATE tblMovies SET Movie_Title ='" + movie_name + "', Movie_Trailer ='" + movie_link + "', Movie_Duration ='" + movie_duration + "', Movie_Genre ='" + genre + "', Release_Date ='" + movie_release + "', Movie_Description ='" + description + "', Poster_path ='" + poster_name + "'  WHERE Movie_title= '" + Session["Movie_title"] + "' ";
            
            if (Session["Movie_title"] == null)
            {
                insert_into_db(insert);
            }
            else
            {
                update_db(update);
                
            }

        }

        private void SqlCmd(string sqlText)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = sqlText;
            cmd.Connection = database.con;
            cmd.ExecuteNonQuery();

        }

        private void insert_into_db(string sqlText)
        {

            onlineTableAdapters.tblMoviesTableAdapter title = new onlineTableAdapters.tblMoviesTableAdapter();
            DataTable dt = new DataTable();
            dt = title.GetData(txtMovieTitle.Text);
            if(dt.Rows.Count > 0)
            {
                Panel1.Visible = false;
                Panel2.Visible = true;
                pnlMessage.Visible = true;
                lblTextMessage.Text = "Movie Title already exists";
            }
            else
            {
                SqlCmd(sqlText);
                Response.Redirect("~/Dashboard/movie.aspx");
            }

            
        }

        private void update_db(string sqlText)
        {

            onlineTableAdapters.tblMoviesTableAdapter title = new onlineTableAdapters.tblMoviesTableAdapter();
            DataTable dt = new DataTable();
            dt = title.GetData(txtMovieTitle.Text);
            if (dt.Rows.Count > 0)
            {
                string select = "SELECT * FROM tblMovies WHERE Movie_title='" + Session["Movie_Title"].ToString() + "'";

                DataRow row = title.GetData(Session["Movie_Title"].ToString())[0] ;

                // Get the value of a specific column in the row
                string value = row["Movie_title"].ToString();

                if (value == txtMovieTitle.Text)
                {
                    SqlCmd(sqlText);
                    Response.Redirect("~/Dashboard/movie.aspx");
                }
                else
                {
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    pnlMessage.Visible = true;
                    lblTextMessage.Text = "Movie title exists";
                }

            }
            else
            {
                SqlCmd(sqlText);
                Response.Redirect("~/Dashboard/movie.aspx");
            }

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
                Session["Movie_Title"] = v;

                string select = "SELECT * FROM tblMovies WHERE Movie_title='" + Session["Movie_Title"].ToString() + "'";

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = select;
                cmd.Connection = database.con;
                cmd.ExecuteNonQuery();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        txtMovieTitle.Text = reader["Movie_title"].ToString();
                        txtMovieLink.Text = reader["Movie_Trailer"].ToString();
                        txtDuration.Text = reader["Movie_Duration"].ToString();
                        u_date = Convert.ToDateTime(reader["Release_Date"]).ToString();
                        ddlGenre.Text = reader["Movie_Genre"].ToString(); 
                        txtDescription.Text = reader["Movie_Description"].ToString();
                        string posterrr = reader["Poster_path"].ToString();

                        Image2.ImageUrl = "~/Dashboard/poster_images/" + posterrr;
                    }
                }
            }

            if (e.CommandName == "Delett")
            {
                int crow;
                crow = Convert.ToInt32(e.CommandArgument.ToString());
                string Movie_id = GridView1.Rows[crow].Cells[6].Text;
                string Movie_name = GridView1.Rows[crow].Cells[1].Text;
                string del = "DELETE FROM  tblMovies WHERE Movie_title='" + Movie_name + "'";
                string del_ = "DELETE FROM  tblShow WHERE Movie_id='" + Movie_id + "'";

                SqlCmd(del_);
                SqlCmd(del);
                
                Response.Redirect("~/Dashboard/movie.aspx");
            }


        }
    }
}