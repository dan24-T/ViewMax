<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ViewMax.Dashboard.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="page_title">
        <h2>Dashboard</h2>
    </div>
    <div class="cards-holder">
        <div class="card" style="background: linear-gradient(#d4bdbd, #9b8484);">
            <div class="c_icon">
                <img src="images/icon-admin-settings-male.png" height="60px"/>
                <h1><%= admin %></h1>
            </div>
            <div class="c_details"><h1>Admin</h1></div>
        </div>
        <div class="card" style="background: linear-gradient(#c0cfe0, #818c98e6);">
            <div class="c_icon">
                <img src="images/icons8-select-users.png" height="60px"/>
                <h1><%= users %></h1>
            </div>
            <div class="c_details"><h1>Users</h1></div>
        </div>
        <div class="card" style="background: linear-gradient(#6060f0, #272764);">
            <div class="c_icon">
                <img src="images/icons8-movie-projector-50.png" height="60px"/>
                <h1><%= movies %></h1>
            </div>
            <div class="c_details"><h1>Movies</h1></div>
        </div>
        <div class="card">
            <div class="c_icon">
                <img src="images/icons8-movie-theater-64.png" height="60px"/>
                <h1><%= halls %></h1>
            </div>
            <div class="c_details"><h1>Halls</h1></div>
        </div>
    </div>
    <div class="stats-holder">
        <div class="bar-graph">
            <canvas id="bar_Graph" style="width:85%; height:80%; margin: 3% 7% 0 8%; background: white;"></canvas>
        </div>
        <div class="pie-chart">

        </div>
    </div>
    <div class="users-holder">
        <div class="log">
            Filter Theatres<br />
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="t_name" DataTextField="Theatre_Name" DataValueField="Theatre_Name" AutoPostBack="True">
                <asp:ListItem>---Filter Theatre---</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="t_name" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Theatre_Id], [Theatre_Name], [Theatre_Location] FROM [tblTheatre]"></asp:SqlDataSource>
            Filter Movies<br />
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="m_name" DataTextField="Movie_title" DataValueField="Movie_title" AutoPostBack="True">
                <asp:ListItem>---Filter Theatre---</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="m_name" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Movie_title], [movie_Id] FROM [tblMovies]"></asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="bookings" AllowPaging="True" AllowSorting="True">
                <Columns>
                    <asp:BoundField DataField="User_name" HeaderText="User_name" SortExpression="User_name" />
                    <asp:BoundField DataField="Movie_title" HeaderText="Movie_title" SortExpression="Movie_title" />
                    <asp:BoundField DataField="Hall_Name" HeaderText="Hall_Name" SortExpression="Hall_Name" />
                    <asp:BoundField DataField="Watch_Date" HeaderText="Watch_Date" SortExpression="Watch_Date" />
                    <asp:BoundField DataField="Watch_time" HeaderText="Watch_time" SortExpression="Watch_time" />
                    <asp:BoundField DataField="B_seats" HeaderText="B_seats" SortExpression="B_seats" />
                     <asp:BoundField DataField="Theatre_Name" HeaderText="Theatre_Name" SortExpression="Theatre_Name" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="bookings" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT tblBookings.User_name, tblMovies.Movie_title, tblHalls.Hall_Name, tblBookings.Watch_Date, tblBookings.Watch_time, tblBookings.B_seats, tblTheatre.Theatre_Name FROM tblBookings INNER JOIN tblMovies ON tblBookings.Movie_id = tblMovies.movie_Id INNER JOIN tblHalls ON tblBookings.Hall_id = tblHalls.Hall_Id INNER JOIN tblTheatre ON tblHalls.Theatre_Id = tblTheatre.Theatre_Id WHERE (tblMovies.Movie_title = @movie) AND (tblTheatre.Theatre_Name = @theatre)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" DefaultValue="" Name="movie" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="theatre" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </div>
    <script>
        var canvas = document.getElementById("bar_Graph");
        var ctx = canvas.getContext('2d');

        var x = canvas.width;
        var y = canvas.height;
        var x_axis = y - (y * 0.10);
        var x_width = x*.8;

        ctx.fillRect(30, x_axis, x_width, 1);

        for (let i = 1; i <= 5; i++) {
            ctx.fillStyle = "#dbd9e1";
            ctx.fillRect(30, x_axis - i * (y * .14), x_width, 1);
        }

        const weekday = ["s", "m", "t", "w", "t", "f", "s"];

        for (let i = 0; i < 7; i++) {
            ctx.fillStyle = "black";
            let day = weekday[i];
            ctx.fillText(day, 40 + i * (x_width * .14), x_axis + 10);
        }

    </script>
</asp:Content>
