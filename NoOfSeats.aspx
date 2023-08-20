<%@ Page Title="" Language="C#" MasterPageFile="~/CheckOut.Master" AutoEventWireup="true" CodeBehind="NoOfSeats.aspx.cs" Inherits="ViewMax.NoOfSeats" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section">
        <div class="holder">
            <div class="prices">
                <div class="starnd"><p>Standard</p><p class="pz">Ksh 900</p></div>
            </div>
            <div class="counter">
                <div id="minus"><span>-</span></div>
                <asp:TextBox ID="txtNoOfSeats" runat="server" Text="3" CssClass="num" ClientIDMode="AutoID"></asp:TextBox>
                <div id="plus"><span>+</span></div>
            </div>
        </div>
        <div class="next">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><span>Ash</span></asp:LinkButton>
        </div>
    </section>
    <script>

        var plus = document.querySelector("#plus"),
            minus = document.querySelector("#minus"),
            num = document.getElementById("<%=txtNoOfSeats.ClientID%>");


        let a = num.value;

        plus.addEventListener("click", () => {
            if (a < 9) {
                a++;
                num.value = a;
                minus.classList.remove("max");
            }
            else {
                plus.classList.add("max");
            }
            
        })

        minus.addEventListener("click", () => {
            if (a > 0) {
                a--;
                num.value = a;
                plus.classList.remove("max");
            }
            else {
                minus.classList.add("max");
            }
            
        })

       
    </script>
</asp:Content>
