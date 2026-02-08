<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectAppWeb.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/stylesheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="SELECT [ItemTitle], [ItemPrice], [ItemDesc], [ItemImage] FROM [Items]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="SELECT [ItemImage], [ItemTitle], [ItemPrice], [ItemDesc] FROM [Items] ORDER BY [ItemPrice]"></asp:SqlDataSource>
    
    <!-- Banner Image -->
    <div class="banner-container">
        <asp:Image ID="ImageBanner" ImageUrl="Images/uniqlo-banner-long.png" runat="server" CssClass="banner-image" />
    </div>

    <!-- List of Products -->
    <div>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
            <LayoutTemplate>
                <div class="product-grid">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="product-card">
                    <img src='<%# Eval("ItemImage", "Images/{0}") %>' alt='<%# Eval("ItemTitle") %>' />
                    <h4><%# Eval("ItemTitle") %></h4>
                    <p class="price">RM <%# Eval("ItemPrice") %></p>
                    <p><%# Eval("ItemDesc") %></p>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
