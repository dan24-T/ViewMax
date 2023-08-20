<%@ Page Title="" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="ViewMax.Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="HomePage.css" rel="stylesheet" type="text/css" />
    <link href="Moviecss.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="main-section">

        <!--FIRST SECTION WITH MOVIE IMAGE-->
        <section class="image-section">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="video">
                         <iframe src='<%# Eval("Movie_Trailer") %>' title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="true"></>></iframe>
                        </div>
                    <div class="img">
                        <img src='<%# "Dashboard/poster_images/" + Eval("Poster_Path") %>'/>
                        <div class="card-details">
                            <p class="span">COMING SPRING</p>
                            <p class="papyrus"><%# Eval("Movie_Title") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [movie_Id], [Movie_title], [Movie_Trailer], [Movie_Genre], [Release_Date], [Movie_Description], [Poster_path], [Movie_Duration] FROM [tblMovies] WHERE ([movie_Id] = @movie_Id)">
                <SelectParameters>
                    <asp:SessionParameter Name="movie_Id" SessionField="movie_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </section>
        <!---FIRST SECTON END-->

        <!---This section just needs more sp[ace and so mch comments ---->

        <!----SECOND SECTION BOOKING SECTION AND THEATRE SELECTION---->
        <section class="second-section">
            <!--SECTION TITLE-->
            <div class="section-title">
               <p>GET TICKETS</p>
           </div>

            <!---SECTION BOOKING AREA--->
            <div class="booking-sect">
                <asp:Panel ID="Panel1" runat="server" CssClass="dates">
                    <asp:HiddenField ID="hpl_Active_Date" runat="server" Value=""/>
                    
                </asp:Panel>

                <%
///
///This condition is to check if the movie is actively showing
///
                    if (Session["showing"].ToString() == "0")
                    {

                        %>
                <div class="theatres">
                    This Movie is not showing at the moment
                </div>
                <%
                    }
                    else
                    {
                    %>
                
                <div class="theatres">
                    <!--Theater 1-->
                   
                    <asp:Repeater ID="rpt_Theatre_Parent" runat="server" OnItemDataBound="rpt_Theatre_Parent_ItemDataBound" >
                        <ItemTemplate>
                            <div class="theatre">
                                <div class="theatre-name">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Theatre_name") %>'></asp:Label>
                                    <p><%# Eval("Theatre_location") %></p>
                                </div>
                                <div class="theatre-halls">
                                    <asp:Label ID="lbl_Theatre_id" CssClass="lbl_Theatre_id" runat="server" Text='<%# Eval("Theatre_Id")%>'></asp:Label>

                                    <!--STANDARS DORMART-->
                                    <asp:Repeater ID="rpt_Halls_Child" runat="server" OnItemDataBound="rpt_Halls_Child_ItemDataBound" >
                                        <ItemTemplate>
                                            <div class="hall">
                                                <div class="hall-name">
                                                    <p><%# Eval("Hall_Formart") %></p>
                                                </div>

                                                <asp:Panel ID="show_times" CssClass="show-times" runat="server">
                                                    <asp:Label ID="lbl_Start_Time" CssClass="lbl_Theatre_id" runat="server" Text='<%# Eval("Start_Time") %>'></asp:Label>
                                                    <asp:Label ID="lbl_End_Time" CssClass="lbl_Theatre_id" runat="server" Text='<%# Eval("End_Time") %>'></asp:Label>
                                                    <asp:Label ID="lbl_Movie_duration" CssClass="lbl_Theatre_id" runat="server" Text=""></asp:Label>
                                                    <asp:Label ID="lbl_hall_id" CssClass="lbl_Theatre_id" runat="server" Text='<%# Eval("Hall_Id") %>'></asp:Label>
                                                    
                                                </asp:Panel>

                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <!--IMAX FORMART-->

                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    
                </div>

                <%} %>
            </div>

        </section>
        <!----SECOND SECTION BOOKING SECTION AND THEATRE SELECTION  END---->

        <!---The above section just need more sp[ace and so mch comments ---->

        <!--LAST SLIDER-->
        <section class="last-slider">
            <div class="section-title">
               <p>ALSO</p>
           </div>
            <div class="container">
                <div class="movie-card">
                    <img src="m_images/slide3.jpg"/>
                    <div class="card-details">
                        <p>MARTIAN</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
                <div class="movie-card">
                    <img src="m_images/slide1.jpg"/>
                    <div class="card-details">
                        <p>AVATAR</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
                <div class="movie-card">
                    <img src="m_images/slide2.jpg"/>
                    <div class="card-details">
                        <p>GUN</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
                <div class="movie-card">
                    <img src="m_images/animeh.jpg"/>
                    <div class="card-details">
                        <p>ANIME</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
                <div class="movie-card">
                    <img src="m_images/slide2.jpg"/>
                    <div class="card-details">
                        <p>MARTIAN</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
                <div class="movie-card">
                    <img src="m_images/Avatar.jpg"/>
                    <div class="card-details">
                        <p>WATER</p>
                        <a href="#">COMING SOON</a>
                    </div>
                </div>
               
            </div>
        </section>
        
    </section>
    <asp:HiddenField ID="Watch_times" runat="server" Value="0" />
    <script>
        var hplactiveDate = document.getElementById("<%=hpl_Active_Date.ClientID%>");
        var ul = document.getElementById("dates_ul");
        var li = ul.children;

        for (let i = 0; i < li.length; i++) {
            
            if (li[i].id == hplactiveDate.value) {
                li[i].classList.add("active")
               
            }
        }

        function sWatch_Times(elem) {
            var val = elem.getAttribute('data-watctms');
            sessionStorage.setItem('Watch_Times', val);
            document.getElementById("<%=Watch_times.ClientID %>").value = sessionStorage.getItem('Watch_Times');

            <% Session["Tests"] = Watch_times.Value; %>
        }


        
    </script>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT tblTheatre.Theatre_Id, tblTheatre.Theatre_Name, tblTheatre.Theatre_Location, COUNT(tblMovies.movie_Id) AS Expr1, tblMovies.movie_Id FROM tblHalls INNER JOIN tblShow ON tblHalls.Hall_Id = tblShow.Hall_Id INNER JOIN tblMovies ON tblShow.Movie_id = tblMovies.movie_Id INNER JOIN tblTheatre ON tblHalls.Theatre_Id = tblTheatre.Theatre_Id GROUP BY tblTheatre.Theatre_Id, tblTheatre.Theatre_Name, tblTheatre.Theatre_Location, tblMovies.movie_Id HAVING (tblMovies.movie_Id = @movie)">
        <SelectParameters>
            <asp:SessionParameter Name="movie" SessionField="movie_id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
