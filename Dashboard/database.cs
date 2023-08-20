using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace ViewMax.Dashboard
{
    public class database
    {
        public static SqlConnection con;

        public static void dbconnection()
        {
            string conString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\Daniel\\source\\repos\\ViewMax\\App_Data\\online.mdf;Integrated Security=True";

            con = new SqlConnection(conString);

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            else
            {
                con.Open();
            }

        }
    }
}