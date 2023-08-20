<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="ViewMax.Dashboard.admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_title">
        <h2>Admin</h2>
    </div>
    <div class="cont">
        <!---This is the first panel this allows us to view our data in tthe db and delete the data-->
        <asp:Panel ID="Panel1" runat="server">
            <div class="holder">
                <div class="count">
                    <img src="images/icon-admin-settings-male.png"/>
                    <span>319 admin</span>
                </div>

                <div class="data-holder">
                    <div class="s-n-add">
                        <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                        <span style="font-weight: 500; margin-left: 10px;">Advanced Search</span>
                       <asp:LinkButton ID="LinkButton7" runat="server" OnClick="Add_Click">add Admin</asp:LinkButton>
                    </div>
                        <br />
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Username" OnRowDeleting="GridView1_RowDeleting" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="No">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
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
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Username], [Email] FROM [tblAdmin]"></asp:SqlDataSource>
                </div>
             </div>
        </asp:Panel>

        <!---Second panel here we have the form, this will allow us to add and submit data  to the db-->
        <asp:Panel ID="Panel2" runat="server">
            <div class="holder">
                <div class="data-hr">
                    <h2>Admin form</h2>
                    <asp:Panel ID="pnlMessage" runat="server" Height="53px" Visible="False" Width="100%" BackColor="#FFCCCC" CssClass="pnlMessage">
                        <asp:Label ID="lblTextMessage" runat="server" Text="lblTextMessage" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </asp:Panel>
                    <div class="profile">
                        <div class="image">
                            <asp:Image ID="Image1" runat="server" Height="174px" Width="174px" BackColor="Gray" CssClass="pfp" />
                            <label for="<%=pfp.ClientID%>">ADD pfp</label>
                        </div>
                        <br />
                        <asp:FileUpload ID="pfp" runat="server" />
                    </div>
                    <div class="names">
                        <div>
                            <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name Required" ForeColor="Red" ValidationGroup="vg">*</asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label2" runat="server" Text="Last Name"></asp:Label>
                            <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        </div>
                        
                    </div>
                    <asp:Label ID="Lbluser" runat="server" Text="username"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUserName" ErrorMessage="Username required" ForeColor="Red" ValidationGroup="vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtUserName" runat="server" ></asp:TextBox><br />
                    <asp:Label ID="lblemail" runat="server" Text="email"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" ErrorMessage="please input your email" ForeColor="Red" ValidationGroup="vg">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="RegularExpressionValidator" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vg">*</asp:RegularExpressionValidator>
                    <br />
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><br />
                    <asp:Label ID="Label7" runat="server" Text="Gender:"></asp:Label>
                    <asp:RadioButton ID="RadioButton1" runat="server" Text="male" GroupName="gender" Checked="True" />
                    <asp:RadioButton ID="RadioButton2" runat="server" Text="Female" GroupName="gender" /><br />
                    <asp:Label ID="Label5" runat="server" Text="password"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPass" ErrorMessage="password Required" ForeColor="Red" ValidationGroup="vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:Label ID="Label6" runat="server" Text="confirm password"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCpass" ErrorMessage="please inpt the confirm password input field" ForeColor="Red" ValidationGroup="vg">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPass" ControlToValidate="txtCpass" ErrorMessage="Password does not match" ForeColor="Red" ValidationGroup="vg">*</asp:CompareValidator>
                    <asp:TextBox ID="txtCpass" runat="server"></asp:TextBox>
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errrorMMMM" ForeColor="Red" ValidationGroup="vg" />
                    <br/>
                    <asp:Button ID="lkbAddAdmin" runat="server" OnClick="lkbAddAdmin_Click" ValidationGroup="vg" Text="Submit"/>
                </div>
            </div>
        </asp:Panel>
        
    </div>
    <script>
        let uploadButton = document.getElementById("<%=pfp.ClientID%>");
        let chosenImage = document.getElementById("<%=Image1.ClientID%>");
        let fileName = document.getElementById("");

        uploadButton.onchange = () => {
            let reader = new FileReader();
            reader.readAsDataURL(uploadButton.files[0]);
            reader.onload = () => {
                chosenImage.setAttribute("src", reader.result);
            }
        }
    </script>
</asp:Content>
