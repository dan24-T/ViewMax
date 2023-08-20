using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ViewMax
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            Session["act_date"] = null;
            var tday = DateTime.Now;
            Session["p_days"] = tday.AddDays(30).ToLongDateString();
            Session["m_days"] = tday.AddDays(-30).ToLongDateString();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string movie_id = commandArgs[0];
            string showing_T = commandArgs[1];
            string duration = commandArgs[2];
       
            Session["movie_id"] = movie_id;
            Session["showing"] = showing_T;
            Session["duration"] = duration;
            Response.Redirect("~/Movie.aspx");
        }
    }
}