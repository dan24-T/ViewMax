using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax.Dashboard
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected int halls, movies, admin, users; 
        protected void Page_Load(object sender, EventArgs e)
        {
            // Establish a database connection
            database.dbconnection();

            // Create a SqlCommand object for counting records in tblAdmin table
            SqlCommand cmdAdmin = new SqlCommand();            
            cmdAdmin.CommandText = "SELECT COUNT(*) FROM tblAdmin";
            cmdAdmin.Connection = database.con;
            admin = Convert.ToInt32(cmdAdmin.ExecuteScalar());

            // Execute the query and store the result in the 'admin' variable
            SqlCommand cmdUsers = new SqlCommand();
            SqlCommand cmdMovies = new SqlCommand();
            SqlCommand cmdHalls = new SqlCommand();
            cmdUsers.CommandText = "SELECT COUNT(*) FROM tblUsers";
            cmdMovies.CommandText = "SELECT COUNT(*) FROM tblMovies";
            cmdHalls.CommandText = "SELECT COUNT(*) FROM tblHalls";

            // Create SqlCommand objects for counting records in tblUsers, tblMovies, and tblHalls tables
            cmdUsers.Connection = database.con;
            cmdMovies.Connection = database.con;
            cmdHalls.Connection = database.con;

            // Execute the queries and store the results in their respective variables
            users = Convert.ToInt32(cmdUsers.ExecuteScalar());
            movies = Convert.ToInt32(cmdMovies.ExecuteScalar());
            halls = Convert.ToInt32(cmdHalls.ExecuteScalar());

            TheatreTableAdapters.DataTable2TableAdapter dataTable2 = new TheatreTableAdapters.DataTable2TableAdapter();


            
        }


    }
}