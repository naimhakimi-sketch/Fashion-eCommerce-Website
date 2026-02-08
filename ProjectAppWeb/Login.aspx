<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProjectAppWeb.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/sign-in.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="form-signin">
            <h1 class="login-title">LOGIN</h1>
            <p class="login-description">Log in with your email address and password.</p>
            
            <div class="input-group">
                <label for="txtUserName">Enter Email:</label>
                <asp:TextBox ID="txtUserName" runat="server" CssClass="input-field" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtUserName" ForeColor="Red" ValidationGroup="Login"></asp:RequiredFieldValidator>&nbsp&nbsp&nbsp
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email" ControlToValidate="txtUserName" ValidationGroup="Login" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>
            </div>
            <div class="input-group">
                <label for="txtPassword">Enter Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" ValidationGroup="Login" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="Login" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>&nbsp&nbsp&nbsp
            </div>

            <div class="button-group">
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-submit" ValidationGroup="Login" />
            </div>

            <p class="status-message">
                <asp:Label ID="lblStatus" runat="server" Text="Status: "></asp:Label>
            </p>
        </div>

    </div>
</asp:Content>
