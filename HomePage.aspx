<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="ViewMax.HomePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="swiper/swiper-bundle.min.css" rel="stylesheet" />
    <link href="HomePage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <section class="main-section">

        <!--First SLIDER-->
       <section class="first-slider">
           <div class="section-title">
               <p>EXPERIENCE IT BIG TIME</p>
           </div>
            <div class="swiper">
              <!-- Additional required wrapper -->
              <div class="swiper-wrapper">
                <!-- Slides -->
                                    
                  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="showing" OnItemCommand="Repeater1_ItemCommand">
                        <ItemTemplate>
                             <div class="swiper-slide">
                                <img src="<%# "Dashboard/poster_images/" + Eval ("Poster_path") %>"/>
                                <div class="card-details" >
                                    <p class="span">COMING SPRING</p>
                                    <p><%# Eval ("Movie_title") %></p>
                                    
                                    <asp:LinkButton ID="LinkButton1" CssClass="showing" runat="server" CommandArgument='<%# Eval("movie_Id")+","+Eval("Showing")+","+Eval("Movie_Duration") %>'><span>GET TICKETS</span></asp:LinkButton>
                                     
                                </div>
                            </div>
                        </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource ID="showing" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Movie_title, Movie_Genre, Poster_path, movie_Id, Showing, Movie_Duration FROM tblMovies WHERE (Release_Date &lt;= @Release_Date) AND (Release_Date &gt;= @Release_Date2)">
                      <SelectParameters>
                          <asp:SessionParameter DbType="Date" Name="Release_Date" SessionField="p_days" />
                          <asp:SessionParameter DbType="Date" Name="Release_Date2" SessionField="m_days" />
                      </SelectParameters>
                  </asp:SqlDataSource>
               
              </div>
              <!-- If we need pagination -->
              <div class="swiper-pagination"></div>

            </div>
       </section>

        <section class="second-slider">
            <div class="section-title">
               <p>COMING SOON</p>
           </div>
            <div class="swiper">
              <!-- Additional required wrapper -->
              <div class="swiper-wrapper">
                <!-- Slides -->
                  <asp:Repeater ID="Repeater2" runat="server" DataSourceID="NowShowing" OnItemCommand="Repeater1_ItemCommand">
                      <ItemTemplate>
                          <div class="swiper-slide">
                            <img src="<%# "Dashboard/poster_images/" + Eval ("Poster_path") %>"/>
                            <div class="card-details">
                                <p class="span">COMING SPRING</p>
                                <p><%# Eval ("Movie_title") %></p>
                                 <asp:LinkButton ID="LinkButton1" CssClass="showing" runat="server" CommandArgument='<%# Eval("movie_Id")+","+Eval("Showing")+","+Eval("Movie_Duration") %>'><span>GET TICKETS</span></asp:LinkButton>
                                
                                

                            </div>
                        </div>
                      </ItemTemplate>
                  </asp:Repeater>
                  <asp:SqlDataSource ID="NowShowing" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [movie_Id], [Movie_title], [Poster_path], [Movie_Genre], [Showing], [Movie_Duration]  FROM [tblMovies] WHERE ([Showing] = @Showing)">
                      <SelectParameters>
                          <asp:Parameter DefaultValue="1" Name="Showing" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                
                
              </div>
              <!-- If we need pagination -->

              <!-- If we need navigation buttons -->
              <div class="swiper-button-prev"></div>
              <div class="swiper-button-next"></div>

            </div>
        </section>

        <!--LAST SLIDER-->
        <section class="last-slider">
            <div class="section-title">
               <p>UPCOMING</p>
           </div>
            <div class="container">
                <asp:Repeater ID="Repeater3" runat="server" DataSourceID="All">
                    <ItemTemplate>
                         <div class="movie-card">
                            <img src="<%# "Dashboard/poster_images/" + Eval ("Poster_path") %>"/>
                            <div class="card-details">
                                <p>MARTIAN</p>
                                <a href="#">COMING SOON</a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                
                <asp:SqlDataSource ID="All" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [movie_Id], [Movie_title], [Poster_path], [Movie_Genre], [Showing] FROM [tblMovies]"></asp:SqlDataSource>
               
            </div>
        </section>

    </section>
    <!-- Slider main container -->

    <script src="swiper.js"></script>
    <script>
        const swiper = new Swiper('.first-slider .swiper', {
            // Optional parameters
            direction: 'horizontal',
            loop: true,

            // If we need pagination
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },

            autoplay: {
                delay: 5000,
            },

        });

        //////-----SECOND SLDER SNIPT
        const swiper2 = new Swiper('.second-slider .swiper', {
            // Optional parameters
            direction: 'horizontal',
            loop: true,

            slidesPerView: 1,
            breakpoints: {

                800: {
                    slidesPerView: 2,
                },
                1000: {
                    slidesPerView: 3,
                },
                1300: {
                    slidesPerView: 4,
                },
            },
            // Navigation arrows
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },

            autoplay: {
                delay: 5000,
            },

        });
    </script>

</asp:Content>
