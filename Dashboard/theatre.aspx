<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="theatre.aspx.cs" Inherits="ViewMax.Dashboard.theatre" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_title">
        <h2>Theatres</h2>
    </div>
    <div class="cont">
        <asp:Panel ID="Panel1" runat="server">
             <div class="holder">
                <div class="count">
                    <img src="images/icon-admin-settings-male.png"/>
                    <span>9 Theatres</span>
                </div>

                <div class="data-holder">
                    <div class="s-n-add">
                        <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                        <span style="font-weight: 500; margin-left: 10px;">Advanced Search</span>
                        <asp:LinkButton ID="LkbAddTheatre" runat="server" OnClick="btnAdd_Click" >Add Theatre</asp:LinkButton>
                    </div>
                    <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" DataKeyNames="Theatre_Name" OnRowCommand="GridView1_RowCommand">

                        <Columns>
                            <asp:TemplateField HeaderText="No">
                            <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                        </asp:TemplateField>
                            <asp:BoundField DataField="Theatre_Name" HeaderText="Theatre Name" />
                            <asp:BoundField DataField="Theatre_Location" HeaderText="Location" />
                            <asp:TemplateField HeaderText="+" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false"  CommandArgument='<%# Container.DataItemIndex %>' CommandName="Editt" Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle CssClass="edit" />
                                <HeaderStyle Width="12.5%" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="-" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Delett" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle CssClass="delete" />
                                <HeaderStyle Width="12.5%" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Theatre_Id">
                            <ControlStyle Width="0%" />
                            <HeaderStyle Width="0%" />
                            <ItemStyle Width="0%" />
                            </asp:BoundField>
                        </Columns>

                     </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Theatre_Name], [Theatre_Location], [Theatre_Id] FROM [tblTheatre]"></asp:SqlDataSource>
                </div>
                 
            </div>
        </asp:Panel>

        <asp:Panel ID="Panel2" runat="server">
            <div class="holder">
                <div class="data-hr">
                    <h2>Theatre form</h2>
                    <asp:Panel ID="pnlMessage" runat="server" BackColor="#FFCCCC" CssClass="pnlMessage" Height="53px" Visible="False">
                        <asp:Label ID="lblTextMessage" runat="server" ForeColor="#CC0000" Text="*"></asp:Label>
                    </asp:Panel>
                    <asp:Label ID="Label1" runat="server" Text="Theatre Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTheatre" ErrorMessage="Theatre name required" ForeColor="Red" ValidationGroup="Vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtTheatre" runat="server"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Theatre Location"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtThLoc" ErrorMessage="location required" ForeColor="Red" ValidationGroup="Vg">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtThLoc" runat="server"></asp:TextBox>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="Vg" />
                    <br />
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmi_Click" ValidationGroup="Vg" />
                </div>
            </div>
        </asp:Panel>
       
    </div>
    
</asp:Content>
