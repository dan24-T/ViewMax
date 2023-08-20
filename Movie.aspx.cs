using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ViewMax
{
    public partial class Movie : System.Web.UI.Page
    {
        protected int i = 0;
        protected int activedate = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (hpl_Active_Date.Value == "")
            {
                hpl_Active_Date.Value = DateTime.Now.ToString();
            }
            else
            {
                hpl_Active_Date.Value = Session["act_date"].ToString();
            }

            Create_Dates();

            if (Session["act_date"] == null)
            {
                Session["act_date"] = hpl_Active_Date.Value;
            }
            else
            {
                hpl_Active_Date.Value = Session["act_date"].ToString();
            }

            rpt_Theatre_Parent.DataSource = SqlDataSource3;
            rpt_Theatre_Parent.DataBind();
        }

        protected void btnDates_Click(object sender, EventArgs e)
        {
            
        }

        protected void Create_Dates()
        {
            HtmlGenericControl ul = new HtmlGenericControl("ul");
            ul.Attributes["id"] = "dates_ul";

            var Today = DateTime.Now;
            
            Panel1.Controls.Add(ul);
            for (int i = 0; i < 9; i++)
            {
                var nday = Today.AddDays(i);
                string date_formart = nday.ToString();
                string dats = nday.ToString("ddd");
                string ndats = nday.ToString("dd");
                string nmats = nday.ToString("MMM");

                HtmlGenericControl li = new HtmlGenericControl("li");
                li.Attributes["id"] = date_formart;
                Button button = new Button();
                HtmlGenericControl span_d = new HtmlGenericControl("span");
                span_d.Attributes["Class"] = "d";
                span_d.InnerText = dats;
                HtmlGenericControl span_m = new HtmlGenericControl("span");
                span_m.Attributes["Class"] = "m";
                span_m.InnerText = nmats;
                HtmlGenericControl span_n = new HtmlGenericControl("span");
                span_n.Attributes["Class"] = "n";
                span_n.InnerText = ndats;

                button.ID = "Btn_" + i;
                button.Click += Set_Active_Date;
                button.CommandArgument = date_formart;
                li.Controls.Add(button);
                li.Controls.Add(span_d);
                li.Controls.Add(span_m);
                li.Controls.Add(span_n);
                ul.Controls.Add(li);
            }
        }

        private void Set_Active_Date(object sender, EventArgs e)
        {
            string date = ((Button)sender).CommandArgument.ToString();
            hpl_Active_Date.Value = date;
            Session["act_date"] = date;
            Response.Redirect("Movie.aspx");

        }

        protected void rpt_Theatre_Parent_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lbl_Theatre = e.Item.FindControl("lbl_Theatre_id") as Label;
            Repeater rptChild = e.Item.FindControl("rpt_Halls_Child") as Repeater;

            DataTable dt = new DataTable();
            dt = hall_dt(lbl_Theatre.Text);
            rptChild.DataSource = dt;
            rptChild.DataBind();

        }

        public DataTable hall_dt(string th_id)
        {
            DataTable dt = new DataTable();
            TheatreTableAdapters.DataTable1TableAdapter the = new TheatreTableAdapters.DataTable1TableAdapter();
            dt = the.GetData(Convert.ToInt32(th_id), Convert.ToInt32(Session["movie_id"].ToString()), Session["act_date"].ToString());

            return dt; 
        }

        protected void rpt_Halls_Child_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lbl_start = e.Item.FindControl("lbl_Start_Time") as Label;
            Label lbl_end = e.Item.FindControl("lbl_End_Time") as Label;
            Label lbl_M_d = e.Item.FindControl("lbl_Movie_duration") as Label;
            Label hall_id = e.Item.FindControl("lbl_hall_id") as Label;
            Panel show_t = e.Item.FindControl("show_times") as Panel;

            var start_time = Convert.ToDateTime(lbl_start.Text);
            var end_date = Convert.ToDateTime(lbl_end.Text);
            var dur = Convert.ToDateTime(Session["duration"]);

            int show_hours_d = end_date.Subtract(start_time).Hours;
            int duration = dur.Hour;

            int no_of_showtimes = (show_hours_d+2) / duration;

            lbl_M_d.Text = no_of_showtimes.ToString();

            var current_time = DateTime.Now.ToShortTimeString();
            DateTime f_c_time = Convert.ToDateTime(current_time);
            var current_date = DateTime.Now.ToShortDateString();
            DateTime f_c_date = Convert.ToDateTime(current_date);

            for (int i = 0; i < no_of_showtimes; i++)
            {

                int inc = duration*i;
                var inc_time = start_time.AddHours(inc).ToShortTimeString();
                DateTime f_i_time = Convert.ToDateTime(inc_time);
                var act_date = Convert.ToDateTime(Session["act_date"].ToString());
                string f_a_date = act_date.ToString("dd/MM/yyyy");                

                LinkButton button = new LinkButton();
                HtmlGenericControl span = new HtmlGenericControl("span");
                span.InnerText = inc_time;
                button.Click += NOOFSEATS;
                button.CommandName = "noofseats";
                button.CommandArgument = inc_time + "," + hall_id.Text;
                if(f_i_time <= f_c_time && current_date.ToString() == f_a_date)
                {
                    button.CssClass = "hide";
                }
                button.Controls.Add(span);
                show_t.Controls.Add(button);

            }      

        }

        private void NOOFSEATS(object sender, EventArgs e)
        {
            string[] commandArg = ((LinkButton)sender).CommandArgument.ToString().Split(new char[] { ',' });
            /*string time = ((LinkButton)sender).CommandArgument.ToString();
            string hall_id = ((LinkButton)sender).CommandArgument.ToString();*/
            string time = commandArg[0];
            string hall_id = commandArg[1];
            Session["w_time"] = time;
            Session["hall_id"] = hall_id;
            Response.Redirect("NoOfSeats.aspx");
        }


    }
}