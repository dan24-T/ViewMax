using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax
{
    public partial class NoOfSeats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["noofseats"] = txtNoOfSeats.Text;

            if (Session["Tests"] != null)
            {
                string s = Session["Tests"].ToString();
            }
           
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("seats.aspx");
        }
    }
}