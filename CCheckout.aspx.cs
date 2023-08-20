using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ViewMax.Dashboard;

namespace ViewMax
{
    public partial class CCheckout : System.Web.UI.Page
    {
        protected string no_of_seats { get; set; }
        protected string mySeats { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            database.dbconnection();

            no_of_seats = Session["noofseats"].ToString();
            mySeats = Session["myseats"].ToString();
        }

        protected void Checkout_Click(object sender, EventArgs e)
        {
            var f_datee = Convert.ToDateTime(Session["w_time"]);
            string ttiimmee = f_datee.ToString("HH:mm:ss");

            string user = Session["name"].ToString();
            int hall = Convert.ToInt32(Session["hall_id"].ToString());
            int movie = Convert.ToInt32(Session["movie_id"].ToString());
            string time = ttiimmee;
            string date = Session["act_date"].ToString();
            string b_seats = Session["myseats"].ToString();
            string arr_b_seats = Session["ar_myseats"].ToString();
            int no_ofBseats =Convert.ToInt32(Session["noofseats"].ToString());
            int no_ofNseats =Convert.ToInt32(Session["noofbseats"].ToString());

            string sqlText = "INSERT INTO tblBookings values('"+user+"', '"+hall+"','"+movie+"', '"+time+"', '"+date+"', '"+b_seats+"' ,'"+no_ofBseats+"')";
            string sqlText1 = "INSERT INTO tblReservations values('" + hall+"', '"+movie+"', '"+time+"', '"+date+"', @value ,'"+no_ofNseats+"')";

            SqlCommand cd = new SqlCommand();
            cd.CommandText = sqlText;
            cd.Connection = database.con;
            cd.ExecuteNonQuery();


            int hal = Convert.ToInt32(Session["hall_id"]);
            int mov = Convert.ToInt32(Session["movie_id"]);
            string timme = ttiimmee;
            DateTime datte = Convert.ToDateTime(Session["act_date"].ToString());
            string datee = datte.ToString("MM/dd/yyyy");

            TheatreTableAdapters.tblReservationsTableAdapter tblReservations = new TheatreTableAdapters.tblReservationsTableAdapter();
            DataTable dtr = new DataTable();
            dtr = tblReservations.GetData(hal, mov, timme, datee);
            if (dtr.Rows.Count > 0)
            {
                SqlCommand cm = new SqlCommand();
                cm.CommandText = "UPDATE tblReservations SET b_seats = @value, no_bseats = '"+ no_ofNseats +"' WHERE Hall_id = '"+hal+"' AND Movie_id = '"+mov+"' AND Watch_time = '"+time+"'  AND Watch_date = '"+date+"'";
                cm.Parameters.AddWithValue("@value", arr_b_seats);
                cm.Parameters.AddWithValue("@time", timme);
                cm.Parameters.AddWithValue("@date", datee);
                cm.Connection = database.con;
                cm.ExecuteNonQuery();
            }
            else
            {
                SqlCommand cm = new SqlCommand();
                cm.CommandText = sqlText1;
                cm.Parameters.AddWithValue("@value", arr_b_seats);
                cm.Connection = database.con;
                cm.ExecuteNonQuery();
            }

            Response.Redirect("HomePage.aspx");
        
        }
    }
}