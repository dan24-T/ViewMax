<%@ Page Title="" Language="C#" MasterPageFile="~/CheckOut.Master" AutoEventWireup="true" CodeBehind="CCheckout.aspx.cs" Inherits="ViewMax.CCheckout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .nholder{
            width: 95%;
            margin: 30px auto 10px;
            display: flex;
            align-items: center;
            position: relative;
            font-weight: 700;
            padding-left: 30px;
        }
        .sholder{
            width: 95%;
            margin: 20px auto 10px;
            display: flex;
            align-items: center;
            position: relative;
            padding-left: 30px;
        }
        .counter{
            position:absolute;
            right: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="section">
        <div class="sholder">
            <div class="prices">
                <div class="starnd"><p><%=no_of_seats%> Standard ticket<%if(no_of_seats != "1") { %>s<%} %></p></div>
            </div>
        </div>
    </section>

    <section class="d-t-h">
        <div class="nholder">
            Reserved Seats
        </div>
    </section>

    <section class="section">
        <div class="sholder">
            <div class="prices">
                <div class="starnd"><p>My Seats</p></div>
            </div>
            <div class="counter">
                <p><%=mySeats%></p>
            </div>
        </div>
    </section>
    
    <div class="next">

        <asp:LinkButton ID="Checkout" runat="server" OnClick="Checkout_Click"><span>Checkout</span></asp:LinkButton>
    </div>
</asp:Content>
