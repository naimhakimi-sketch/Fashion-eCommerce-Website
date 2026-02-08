<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginStatus.ascx.cs" Inherits="ProjectAppWeb.UserControls.LoginStatus" %>

<div class="login-status-container">
    <div class="login-status">
        <asp:HyperLink ID="HyperLinkLogin" runat="server" NavigateUrl="~/Login.aspx" CssClass="login-button">Login</asp:HyperLink>
        &nbsp;&nbsp;
        <asp:HyperLink ID="HyperLinkRegister" runat="server" NavigateUrl="~/Register.aspx" CssClass="register-button">Register</asp:HyperLink>
        &nbsp;&nbsp;
        <asp:Label ID="lblLoginStatus" runat="server" CssClass="login-status-label"></asp:Label>&nbsp;&nbsp;
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />
        <asp:Button ID="btnPurchase" runat="server" Text="Purchase" OnClick="btnPurchase_Click" CssClass="purchase-button" Visible="False" />
    </div>
</div>
