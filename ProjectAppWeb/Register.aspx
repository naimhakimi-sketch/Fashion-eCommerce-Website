<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ProjectAppWeb.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/sign-in.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="form-signin">
            <h1 class="login-title">CREATE AN ACCOUNT</h1>
            <p class="login-description">Register today for free!</p>

            <div class="input-group">
                <label for="txtUserName">Email Address:</label>
                <asp:TextBox ID="txtUserName" runat="server" CssClass="input-field"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ValidationGroup="Register" ControlToValidate="txtUserName" ForeColor="Red"></asp:RequiredFieldValidator>&nbsp&nbsp&nbsp
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ValidationGroup="Register" ControlToValidate="txtUserName" ForeColor="Red"></asp:RegularExpressionValidator>
            </div>

            <div class="input-group">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="txtPassword" ForeColor="Red" ValidationGroup="Register"></asp:RequiredFieldValidator>&nbsp&nbsp&nbsp
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Minimum eight characters, at least one letter and one number" ControlToValidate="txtPassword" ForeColor="Red" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ValidationGroup="Register"></asp:RegularExpressionValidator>
            </div>

            <div class="button-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn-submit" ValidationGroup="Register" />
            </div>

            <p class="status-message">
                <asp:Label ID="lblStatus" runat="server" Text="Status: "></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>
