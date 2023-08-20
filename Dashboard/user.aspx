<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard/SideBar.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="ViewMax.Dashboard.user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_title">
        <h2>Users</h2>
    </div>
     <div class="cont">
        <div class="holder">
            <div class="count">
                <img src="images/icons8-select-users.png"/>
                <span>3219 Users</span>
            </div>

            <div class="data-holder">
                <div class="s-n-add">
                    <asp:TextBox ID="SearchBox" runat="server" placeholder="Search name"></asp:TextBox>
                    <span style="font-weight: 500; margin-left: 10px;">Advanced Search</span>
                </div>
                <div class="table">
                    <table style="width: 100%;">
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th colspan="2" style="width: 20%; text-align: center;">Actions</th>
                        </tr>
                        <tr>
                            <td>User</td>
                            <td>aerw@haji.com</td>
                            <td>
                                <asp:LinkButton ID="lkbEdit" runat="server" CssClass="edit">edit</asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton ID="lkbDelete" runat="server" CssClass="delete">delete</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>A niffa</td>
                            <td>weerw@gatr.com</td>
                            <td>
                                <asp:LinkButton ID="lbb" runat="server" CssClass="edit">edit</asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton ID="lkb2" runat="server" CssClass="delete">delete</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>A niffa</td>
                            <td>weerw@gatr.com</td>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="edit">edit</asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="delete">delete</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>A niffa</td>
                            <td>weerw@gatr.com</td>
                            <td>
                                <asp:LinkButton ID="LinkButton3" runat="server" CssClass="edit">edit</asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton4" runat="server" CssClass="delete">delete</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>A niffa</td>
                            <td>weerw@gatr.com</td>
                            <td>
                                <asp:LinkButton ID="LinkButton5" runat="server" CssClass="edit">edit</asp:LinkButton>

                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton6" runat="server" CssClass="delete">delete</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
