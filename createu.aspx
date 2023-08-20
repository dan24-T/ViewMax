<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="createu.aspx.cs" Inherits="ViewMax.createu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="signin.css" />
</head>
<body>
    <section>
        <form id="form1" runat="server">
            <asp:Panel ID="SignUp_Panel" runat="server" CssClass="sign_up_box">
                 <div class="form">
                     
                    <h2>Sign Up</h2>

                     <asp:Panel ID="pnl_error" runat="server" BackColor="#FF9999" Visible="False">
                         <asp:Label ID="lblError" runat="server" ForeColor="Red" Text="Label" Height="50px"></asp:Label>
                     </asp:Panel>

                    <div class="multi_input_box">
                        <div class="input_box">
                            <asp:TextBox ID="txtFName" runat="server" autocomplete="off" placeholder="Enter First Name"></asp:TextBox>
                            <label for="">First Name <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="First name required" ControlToValidate="txtFName" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator></label>
                        </div>
                        <div class="input_box">
                            <asp:TextBox ID="txtLName" runat="server" autocomplete="off" placeholder="Enter Last Name"></asp:TextBox>
                            <label for="">Last Name </label>
                            
                        </div>
                    </div>
                    <div class="input_box">
                        <asp:TextBox ID="txtUserName" runat="server" autocomplete="off" placeholder="Enter username"></asp:TextBox>
                        <label for="">Username <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Username required" ControlToValidate="txtUsername" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator></label>
                        
                    </div>
                    <div class="input_box">
                        <asp:TextBox ID="txtEmail" runat="server" autocomplete="off" placeholder="Enter Your Email"></asp:TextBox>
                        <label for="">Email 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email Required" ControlToValidate="txtEmail" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="valid email must contain @ and ." ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vg">*</asp:RegularExpressionValidator>
                        </label>
                        
                    </div>
                    <div class="input_box">
                        <asp:TextBox ID="txtPass" runat="server" autocomplete="off" placeholder="Enter Your Password" TextMode="Password"></asp:TextBox>
                        <img src="Dashboard/images/icons8-closed-eye-32.png" id="eyeicon"/>
                        <label for="">Password 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="password required" ControlToValidate="txtPass" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator>
                            
                        </label>
                        
                    </div>
                    <div class="input_box">
                        <asp:TextBox ID="txtCPass" runat="server" autocomplete="off" placeholder="Confirm Password"></asp:TextBox>
                        <label for="">Confirm password 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Confirm Password required" ControlToValidate="txtCPass" ValidationGroup="vg" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match" ControlToCompare="txtPass" ControlToValidate="txtCPass" ForeColor="Red" ValidationGroup="vg">*</asp:CompareValidator>
                        </label>
                        
                    </div>
                    <div>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vg" ForeColor="Red" />
                    </div>
                    <div class="button">
                        <asp:Button ID="Button1" runat="server" Text="Button" ValidationGroup="vg" OnClick="Button1_Click" />
                    </div>        

                    <div class="p">
                        <p>Alraedy have an account? <asp:LinkButton ID="LinkButton1" runat="server">Sign in</asp:LinkButton></p>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnl_pfp" runat="server" CssClass="sign_up_box">
                <div class="form">
                    <h2>Select Profile</h2>
                    <div class="pfp_h">
                        <asp:Image ID="Image1" runat="server"/>
                        <label for="<%=pfp.ClientID%>">ADD pfp</label>
                    </div>
                    <asp:FileUpload ID="pfp" runat="server" CssClass="hide"/>
                    <div>
                        <asp:Button ID="Addprofile" runat="server" Text="Add Profile" OnClick="Addprofile_Click" />
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/HomePage.aspx">Skip</asp:HyperLink>
                    </div>
                </div>
            </asp:Panel>
        </form>
    </section>
    <script>
        var icon = document.getElementById("eyeicon");
        var pass = document.getElementById("<%=txtPass.ClientID %>");

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
</body>
</html>
