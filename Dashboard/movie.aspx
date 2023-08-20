<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="movie.aspx.cs" Inherits="ViewMax.Dashboard.movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_title">
        <h2>Movies</h2>
    </div>
     <div class="cont">
         <!---Panel 1 we have the details here--->
         <asp:Panel ID="Panel1" runat="server">
            <div class="holder">
            <div class="count">
                <img src="images/icons8-movie-projector-50.png"/>
                <span>19 Movies</span>
            </div>

            <div class="data-holder">
                <div class="s-n-add">
                    <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                    <span style="font-weight: 500; margin-left: 10px;">Advanced Search</span>
                    <asp:LinkButton ID="lkbAddMovie" runat="server" OnClick="lkbAddMovie_Click">Add Movie</asp:LinkButton>
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="Movie_title" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="No">
                            <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Movie_Title" HeaderText="Movie Title" />
                        <asp:TemplateField HeaderText="Movie Poster">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/Dashboard/poster_images/" + Eval("Poster_path")%>' AlternateText="No poster" />
                            </ItemTemplate>
                            <ControlStyle Height="80px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Movie_Genre" HeaderText="Genre" />
                        <asp:TemplateField HeaderText="+" ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Editt" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                            <ControlStyle CssClass="edit" />
                            <HeaderStyle Width="12.5%" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="-" ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="Delett" CommandArgument='<%# Container.DataItemIndex %>' Text="delete"></asp:LinkButton>
                            </ItemTemplate>
                            <ControlStyle CssClass="delete" />
                            <HeaderStyle Width="12.5%" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Movie_id">
                        <HeaderStyle Width="0%" />
                        <ItemStyle Width="0%" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Movie_title], [Movie_Genre], [Poster_path], [movie_Id] FROM [tblMovies]"></asp:SqlDataSource>
            </div>
        </div>
         </asp:Panel>

         <asp:Panel ID="Panel2" runat="server">
             <div class="holder">
                <div class="data-hr">
                    <h2>Movie form</h2>
                    <asp:Panel ID="pnlMessage" runat="server" BackColor="#FFCCCC" CssClass="pnlMessage" Height="53px" Visible="False">
                        <asp:Label ID="lblTextMessage" runat="server" ForeColor="#CC0000" Text="*"></asp:Label>
                    </asp:Panel>
                    <asp:Label ID="Label7" runat="server" Text="Movie Image"></asp:Label>
                    <div class="profile">
                        <div class="image">
                            <asp:Image ID="Image2" runat="server" Height="174px" Width="230px" BackColor="Gray" />
                            <label for="<%=poster.ClientID%>">ADD pfp</label>
                        </div>
                        <br />
                        <asp:FileUpload ID="poster" runat="server" />
                    </div>
                    <asp:Label ID="Label1" runat="server" Text="Movie Title"></asp:Label>
                    <asp:TextBox ID="txtMovieTitle" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Trialer Link"></asp:Label>
                    <asp:TextBox ID="txtMovieLink" runat="server"></asp:TextBox>
                    <asp:Label ID="Label3" runat="server" Text="Duration"></asp:Label>
                    <asp:TextBox ID="txtDuration" runat="server" TextMode="Time">0</asp:TextBox>
                    <br />
                    <asp:Label ID="Label5" runat="server" Text="genre"></asp:Label><br />
                    <asp:DropDownList ID="ddlGenre" runat="server">
                        <asp:ListItem>Action</asp:ListItem>
                        <asp:ListItem>Adventure</asp:ListItem>
                        <asp:ListItem>Animated</asp:ListItem>
                        <asp:ListItem>Comedy</asp:ListItem>
                        <asp:ListItem>Drama</asp:ListItem>
                        <asp:ListItem>Sc-Fi</asp:ListItem>
                        <asp:ListItem>Fantasy</asp:ListItem>
                        <asp:ListItem>History</asp:ListItem>
                        <asp:ListItem>Horror</asp:ListItem>
                        <asp:ListItem>Musical</asp:ListItem>
                        <asp:ListItem>Noir</asp:ListItem>
                        <asp:ListItem>Romance</asp:ListItem>
                        <asp:ListItem>Thriller</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Release Date"></asp:Label>
                    <asp:TextBox ID="txtReleaseDate" runat="server" type="Date"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Movie Description"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="7"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnSubmitMovie" runat="server" Text="Submit" OnClick="btnSubmitMovie_Click" />
                </div>
            </div>
         </asp:Panel>
        
    </div>
    <script>
        let uploadButton = document.getElementById("<%=poster.ClientID%>");
        let chosenImage = document.getElementById("<%=Image2.ClientID%>");
        let fileName = document.getElementById("");

        <%if (Session["Movie_Title"] != null) {%>
        var u_date = document.getElementById("<%=txtReleaseDate.ClientID%>");
        const dateValue = new Date("<%=u_date%>");
        u_date.value = dateValue; 
        <% }%>

        uploadButton.onchange = () => {
            let reader = new FileReader();
            reader.readAsDataURL(uploadButton.files[0]);
            reader.onload = () => {
                chosenImage.setAttribute("src", reader.result);
            }
        }
    </script>
</asp:Content>
