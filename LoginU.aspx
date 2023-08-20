<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginU.aspx.cs" Inherits="ViewMax.LoginU" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="StyleSheet1.css" runat="server"/>
    <link href="signin.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <section>
        <div class="form_box">
            <form id="form1" runat="server">
                <div class="form">
                    <h2>Login</h2>
                     <asp:Panel ID="pnl_error" runat="server" BackColor="#FF9999" Visible="False">
                         <asp:Label ID="lblError" runat="server" ForeColor="Red" Text="Label" Height="50px"></asp:Label>
                     </asp:Panel>
                    <div class="input_box">
                        <asp:TextBox ID="txtUsername" runat="server" autocomplete="off" placeholder="Your username"></asp:TextBox>
                        <label for="">Username <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtUsername" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator></label>
              
                    </div>
                    
                    <div class="input_box">
                        <asp:TextBox ID="txtPassword" runat="server" autocomplete="off" placeholder="enter password" TextMode="Password"> </asp:TextBox>
                        <img src="Dashboard/images/icons8-closed-eye-32.png" id="eyeicon"/>
                        <label for="">Password <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtPassword" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator></label>
                        
                    </div>
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vg" ForeColor="Red" />
                    </div>
                    <div class="p">
                        <p>Forgot password <a href="#">click here</a></p>
                    </div>
                    <div class="button">
                        <asp:Button ID="Button1" runat="server" Text="Log In" OnClick="Button1_Click" ValidationGroup="vg" />
                    </div> 
                    
                    <div class="p">
                        <p>Dont have an account? <asp:LinkButton ID="signUp" runat="server" OnClick="signUp_Click" >SignUp</asp:LinkButton></p>
                    </div>
                </div>
            </form>
        </div>
        
    </section>
    <script>

        var icon = document.getElementById("eyeicon");
        var pass = document.getElementById("<%=txtPassword.ClientID %>");

        icon.onclick = function () {
            if (pass.type == "password") {
                pass.type = "text";
                icon.src = "Dashboard/images/icons8-eye-50.png";
            }
            else {
                pass.type = "password"; 
                icon.src = "Dashboard/images/icons8-closed-eye-32.png";
            }
        }
  
    </script>
</body>
</html>
