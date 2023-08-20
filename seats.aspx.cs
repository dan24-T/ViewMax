using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax
{
    public partial class seats : System.Web.UI.Page
    {
        protected string created_seats { get; set; }
        protected int rows { get; set; }
        protected int columns { get; set; }
        protected string booked_seats { get; set; }
        protected string no_of_seats { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var f_datee = Convert.ToDateTime(Session["w_time"]);
            string ttiimmee = f_datee.ToString("HH:mm:ss");  
            //Response.Write(ttiimmee);
            // Access the tblHallsTableAdapter to retrieve hall data based on hall_id from session
            TheatreTableAdapters.tblHallsTableAdapter halls = new TheatreTableAdapters.tblHallsTableAdapter();
            DataRow row = halls.GetData(Convert.ToInt32(Session["hall_id"].ToString()))[0];

            // Extract the seat information from the retrieved row
            string h_seats = row["SeatSpaces_1"].ToString();
            int h_rows = Convert.ToInt32(row["Rows"].ToString());
            int h_cols = Convert.ToInt32(row["Cols"].ToString());

            // Set the properties for the page
            created_seats = h_seats;
            rows = h_rows;
            columns = h_cols + 1;

            // Retrieve relevant information from the session
            int hal = Convert.ToInt32(Session["hall_id"]);
            int mov = Convert.ToInt32(Session["movie_id"]);
            string timme = ttiimmee/*Session["w_time"].ToString()*/;
            DateTime datte = Convert.ToDateTime(Session["act_date"].ToString());
            string datee = datte.ToString("MM/dd/yyyy");

            // Access the tblReservationsTableAdapter to retrieve reservation data based on hall, movie, time, and date
            TheatreTableAdapters.tblReservationsTableAdapter tblReservations = new TheatreTableAdapters.tblReservationsTableAdapter();
            DataTable dtr = new DataTable();
            dtr = tblReservations.GetData(hal, mov, timme, datee);

            if (dtr.Rows.Count > 0)
            {
                // If there are reservations, retrieve the booked seats from the first row
                DataRow rw = tblReservations.GetData(hal, mov, timme, datee)[0];
                booked_seats = rw["b_seats"].ToString();
            }
            else
            {
                // If there are no reservations, set the booked seats to an empty array
                booked_seats = "[]";
            }

            // Retrieve the number of seats from the session
            no_of_seats = Session["noofseats"].ToString();

            // Set session variables
            Session["myseats"] = MySeats.Value;
            Session["ar_myseats"] = arr_MySeats.Value;
            Session["noofbseats"] = B_seats_length.Value;
        }

        protected void lsa_Click(object sender, EventArgs e)
        {
            // Check if the selected number of seats matches the expected number of seats
            if (seats_length.Value != no_of_seats)
            {
                // Display an alert if the number of seats is not as expected
                //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Please Select : " + no_of_seats + "');", true);
            }
            else
            {
                // Redirect to the CCheckout.aspx page
                Response.Redirect("CCheckout.aspx");
            }
        }
    }
}
