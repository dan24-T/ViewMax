<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="ViewMax.Dashboard.Show" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h1>ShowTimes</h1>
    <div class="cont">
        <asp:Panel ID="Panel1" runat="server">
            <div class="holder">
                <div class="count">
                    <img src="images/icons8-movie-projector-50.png"/>
                    <span>19 Movies showing</span>
                </div>

                <div class="data-holder">
                    <div class="s-n-add">
                        <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                        <span style="font-weight: 500; margin-left: 10px;">Advanced Search</span>
                        <asp:LinkButton ID="lkbShow_movie" runat="server" OnClick="lkbShow_movie_Click" >Add show times</asp:LinkButton>
                    </div>
                     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" OnRowDeleting="GridView1_RowDeleting" DataSourceID="SqlDataSource1" DataKeyNames="Show_Id,movie_Id">
                         <Columns>
                             <asp:TemplateField HeaderText="No">
                                <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                 <HeaderStyle Width="10%" />
                                </asp:TemplateField>
                             <asp:BoundField DataField="Movie_title" HeaderText="Movie" SortExpression="Movie_title" />
                             <asp:BoundField DataField="Hall_Name" HeaderText="Hall  Name" SortExpression="Hall_Name" />
                             <asp:BoundField DataField="Theatre_Name" HeaderText="Theatre Name" SortExpression="Theatre_Name" />

                             <asp:ButtonField CommandName="delete" HeaderText="-" Text="remove">
                             <ControlStyle CssClass="delete" />
                             <HeaderStyle Width="12.5%" />
                             <ItemStyle HorizontalAlign="Center" />
                             </asp:ButtonField>

                             <asp:BoundField DataField="Show_id">
                             <HeaderStyle Width="0%" />
                             <ItemStyle Width="0%" />
                             </asp:BoundField>

                         </Columns>
                </asp:GridView>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT tblShow.Movie_id, tblShow.Hall_Id, tblMovies.Movie_title, tblHalls.Hall_Name, tblTheatre.Theatre_Name, tblShow.Show_Id, tblMovies.movie_Id AS Expr1, tblHalls.Hall_Id AS Expr2, tblTheatre.Theatre_Id FROM tblShow INNER JOIN tblMovies ON tblShow.Movie_id = tblMovies.movie_Id INNER JOIN tblHalls ON tblShow.Hall_Id = tblHalls.Hall_Id INNER JOIN tblTheatre ON tblHalls.Theatre_Id = tblTheatre.Theatre_Id"></asp:SqlDataSource>
                </div>
                </div>
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server">
            <div class="holder">
                <div class="data-hr">
                    <h2>Show form</h2>
                     <asp:Panel ID="pnlMessage" runat="server" Height="53px" Visible="False" Width="100%" BackColor="#FFCCCC" CssClass="pnlMessage">
                        <asp:Label ID="lblTextMessage" runat="server" Text="lblTextMessage" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </asp:Panel>
                    <asp:Label ID="Label1" runat="server" Text="Start Date"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtShowDate" runat="server" TextMode="Date" min="" onchange="validateDate()"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label5" runat="server" Text="End Date"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtSEndDate" runat="server" TextMode="Date" AutoPostBack="True" OnTextChanged="txtSEndDate_TextChanged"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Start Time"></asp:Label>
                    <asp:TextBox ID="txtStart_Time" runat="server" TextMode="Time"></asp:TextBox>
                    <asp:Label ID="lblend" runat="server" Text="End Time"></asp:Label>
                    <asp:TextBox ID="txtEnd_Time" runat="server" AutoPostBack="true" TextMode="Time" OnTextChanged="txtEnd_Time_TextChanged"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label3" runat="server" Text="Movie "></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlMovie_Name" runat="server" DataSourceID="Movie_ds" DataTextField="Movie_title" DataValueField="movie_Id"></asp:DropDownList>
                    <asp:SqlDataSource ID="Movie_ds" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [movie_Id], [Movie_title] FROM [tblMovies] WHERE ([Release_Date] &lt;= @Release_Date)">
                        <SelectParameters>
                            <asp:SessionParameter DbType="Date" Name="Release_Date" SessionField="v_date" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="Label4" runat="server" Text="Theatre"></asp:Label>
                    <br />
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="Theatre" DataTextField="Theatre_Name" DataValueField="Theatre_Id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="Theatre" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Theatre_Id], [Theatre_Name] FROM [tblTheatre]"></asp:SqlDataSource>
                    <br />
                    <asp:Label ID="lblHall" runat="server" Text="Theatre Hall"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlHall_Name" runat="server" DataSourceID="Hall_DS" DataTextField="Hall_Name" DataValueField="Hall_Id">
                        <asp:ListItem>0</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="Hall_DS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Hall_Id], [Hall_Name] FROM [tblHalls] WHERE ([Theatre_Id] = @Theatre_Id)">
                        <SelectParameters>
                            <asp:SessionParameter Name="Theatre_Id" SessionField="the_id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
                </div>
            </div>
        </asp:Panel>
    </div>
    
    <script>
        const today = new Date().toISOString().split('T')[0];
        document.getElementById("<%=txtShowDate.ClientID%>").min = today;

        function validateDate() {
            const inputDate = document.getElementById("<%=txtShowDate.ClientID%>").value;
            if (inputDate < today) {
                document.getElementById("<%=txtShowDate.ClientID%>").value = today;
            }
        }
    </script>
</asp:Content>
