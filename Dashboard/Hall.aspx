<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="Hall.aspx.cs" Inherits="ViewMax.Dashboard.Hall" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="seats.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_title">
        <h2>Halls</h2>
    </div>
    <div class="cont">
        <!---Here we hav the first panel---->
        <asp:Panel ID="Panel1" runat="server">
             <div class="holder">
            <div class="count">
                <img src="images/icon-admin-settings-male.png"/>
                <span>9 Theatres</span>
            </div>

            <div class="data-holder">
                <div class="s-n-add">
                    <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                    &nbsp;<asp:LinkButton ID="LinkButton7" runat="server" OnClick="LinkButton7_Click" >add halls</asp:LinkButton>
                    <asp:Button ID="btnsarch" runat="server" Text="Search" />
                </div>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Hall_Id" OnRowDeleting="GridView1_RowDeleting" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="No">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Hall_Name" HeaderText="Hall Names" />
                            <asp:BoundField DataField="Hall_Formart" HeaderText="Screen Formart" />
                            <asp:BoundField DataField="No_of_seats" HeaderText="No of Seats" />
                            <asp:TemplateField HeaderText="+" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Editt" Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle CssClass="edit" />
                                <HeaderStyle HorizontalAlign="Center" Width="12.5%" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:ButtonField CommandName="Delete"  Text="Delete" >
                            <ControlStyle CssClass="delete" />
                            <HeaderStyle Width="12.5%" />
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:BoundField DataField="Hall_Id" />
                        </Columns>
                    </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Hall_Name], [Hall_Formart], [No_of_seats], [Hall_Id] FROM [tblHalls]"></asp:SqlDataSource>
            </div>
        </div>
        </asp:Panel>

        <!---Here we have the seecond panel --->
        <asp:Panel ID="Panel2" runat="server">
            <div class="holder">
                <div class="data-hr">
                    <h2>Hall form</h2>
                    <asp:Panel ID="pnlMessage" runat="server" Height="53px" Visible="False" Width="100%" BackColor="#FFCCCC" CssClass="pnlMessage">
                        <asp:Label ID="lblTextMessage" runat="server" Text="lblTextMessage" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </asp:Panel>
                    <asp:Label ID="Label1" runat="server" Text="Hall Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtHallName" ErrorMessage="hall is required" ForeColor="Red" ValidationGroup="Vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtHallName" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Format"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFormart" ErrorMessage="hall is required" ForeColor="Red" ValidationGroup="Vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtFormart" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblTheatr" runat="server" Text="Theatre"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Theatre_Name" DataValueField="Theatre_Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Theatre_Id], [Theatre_Name] FROM [tblTheatre]"></asp:SqlDataSource>
                    <br />
                    <h3>Seat arrangement</h3>
                    <asp:Label ID="lblRows" runat="server" Text="max rows :  "></asp:Label><i class="span">select the maximum number of rows</i>
                    <asp:DropDownList ID="ddlRows" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRows_SelectedIndexChanged">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:Label ID="lblCols" runat="server" Text="max columns :  "></asp:Label><i class="span">select the maximum number of columns</i>
                    <asp:DropDownList ID="ddlColumns" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlColumns_SelectedIndexChanged">
                         <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
             <div class="seat_box">
                <div class="seat_cont">
                        <%
                         int c = 64;
                            for (int i=0; i < row; i++)
                            {
                                c++;
                            %>  
                    <div class="seat_row" id="<%= (char)c%>"> 
                                <%
                                    for (int j=0; j< column;j++)
                                    {
                                %>
                    <div class="seat_space" id="<%= (char)c%><%=j+1 %>" onclick="addToArray(this.id)">
                        <div class="seat">

                        </div>
                    </div>
                    <%
                            }
                            %></div><%
                        } %>
                </div>
            </div>
            <asp:HiddenField ID="txtSeats" runat="server" />
            <asp:HiddenField ID="txtNoseats" runat="server" Value="0" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="Vg" />
            <br />
            <asp:Button ID="BtnSub" runat="server" Text="Submit" OnClick="BtnSub_Click" ValidationGroup="Vg" />
            <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
        </asp:Panel>
    </div>

    <script>
        function view(elem) {
            var thnad = elem.parentElement;
            var theatre = thnad.parentElement;
            var halls = document.querySelectorAll(".halls");

            const index = Array.from(theatre.parentElement.children).indexOf(theatre);

            if (halls[index].classList.contains("viewed")) {
                halls[index].classList.remove("viewed");
            } else {
                halls[index].classList.add("viewed");
            }

            console.log(index);
        }


        const r = <%=row%>;
        const cl =<%=column%>;



        var arr = Array.from(Array(r), () => new Array());

        <%if (Session["Hall"] != null) {%>

        var srrrr = document.querySelectorAll(".seat_row");
        arr = <%=sseats%>;

        for (let i = 0; i < <%=row%>; i++) {

            let seat_row_id = srrrr[i].id;
            let seat_space = document.getElementById(seat_row_id).children;
            for (let j = 0; j < seat_space.length; j++) {
                if (arr[i].includes(seat_space[j].id) == true) {
                    seat_space[j].style.background = "blue";
                }
            }
            
        }

        <%}%>
        console.log(arr);

        


        function addToArray(elem) {
            let x = elem.charAt(0);
            let c = 64;
            for (let i = 0; i < <%= row %>; i++) {
                c++;
                if (x === String.fromCharCode(c)) {
                    let itdo = arr[i].includes(elem);
                    let name = document.getElementById(elem);

                    if (itdo !== true) {
                        arr[i].push(elem);
                        name.style.background = "blue";
                    }
                    else {
                        let ind = arr[i].indexOf(elem);
                        arr[i].splice(ind, 1);
                        name.style.background = "#dbd9e1";
                    }
                    //console.log("[[" + arr.join("],[") + "]]");

                    function arrayToString(arr) {
                        // Check if input is a 2D array
                        if (!Array.isArray(arr) || arr.some(innerArr => !Array.isArray(innerArr))) {
                            return "Input is not a 2D array.";
                        }

                        // Convert each inner array to a string
                        const stringArr = arr.map(innerArr => "['" + innerArr.join("','") + "']");

                        // Join the string arrays with commas and return as a single string
                        return "[" + stringArr.join(",") + "]";
                    }

                    // Example usage
                    const arrString = arrayToString(arr);
                    console.log(arrString);
                    

                    document.getElementById("<%=txtSeats.ClientID%>").value = arrString;
                    

                    var count = 0;
                    for (let i = 0; i < arr.length; i++) {
                        for (let j = 0; j < arr[i].length; j++) {
                            count++;

                        }
                    }

                    document.getElementById("<%=txtNoseats.ClientID%>").value = count;
                }
            }

        }

    </script>
</asp:Content>
