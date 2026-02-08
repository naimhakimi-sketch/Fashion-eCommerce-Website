<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="ShopItem.aspx.cs" Inherits="ProjectAppWeb.ShopItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/StyleSheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sales-container">
        <div class="section-header">
            <h3>Shop Items</h3>
            <div class="sales-info">
                <div class="info-item">
                    <strong>Sales ID:</strong>
                    <asp:Label ID="lblSalesId" runat="server" CssClass="info-label"></asp:Label>
                </div>
                <div class="info-item">
                    <strong>Date & Time:</strong>
                    <asp:Label ID="lblDateTime" runat="server" CssClass="info-label"></asp:Label>
                </div>
            </div>
        </div>

        <div class="filter-section">
            <label for="ddlCategory" class="filter-label">Choose Category:</label>
            <asp:DropDownList 
                ID="ddlCategory" 
                runat="server" 
                AutoPostBack="True" 
                DataSourceID="SqlDataSourceCategories" 
                DataTextField="CatName" 
                DataValueField="CatId" 
                OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" 
                CssClass="dropdown">
            </asp:DropDownList>
        </div>

        <asp:GridView 
            ID="GridViewItems" 
            runat="server" 
            AllowPaging="True" 
            AutoGenerateColumns="False" 
            DataKeyNames="ItemId" 
            DataSourceID="SqlDataSourceItems" 
            OnSelectedIndexChanged="GridViewItems_SelectedIndexChanged" 
            CssClass="item-table">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ItemId" HeaderText="ID" SortExpression="ItemId" />
                <asp:BoundField DataField="ItemTitle" HeaderText="Title" SortExpression="ItemTitle" />
                <asp:BoundField DataField="ItemPrice" HeaderText="Price" SortExpression="ItemPrice" DataFormatString="RM {0}" />
                <asp:BoundField DataField="ItemDesc" HeaderText="Description" SortExpression="ItemDesc" />
                <asp:ImageField DataImageUrlField="ItemImage" DataImageUrlFormatString="Images/{0}" HeaderText="Image">
                    <ControlStyle Width="120px" />
                </asp:ImageField>
            </Columns>
        </asp:GridView>

        <div class="details-section">
            <h4>Selected Item Details</h4>
            <div class="detail-row">
                <span><strong>ID:</strong></span>
                <asp:Label ID="lblItemId" runat="server" CssClass="detail-label"></asp:Label>
            </div>
            <div class="detail-row">
                <span><strong>Title:</strong></span>
                <asp:Label ID="lblItemTitle" runat="server" CssClass="detail-label"></asp:Label>
            </div>
            <div class="detail-row">
                <span><strong>Price:</strong></span>
                <asp:Label ID="lblItemPrice" runat="server" CssClass="detail-label"></asp:Label>
            </div>

            <div class="action-row">
                <label for="txtQuantity">Quantity:</label>
                <asp:TextBox 
                    ID="txtQuantity" 
                    runat="server" 
                    TextMode="Number" 
                    CssClass="quantity-input" 
                    Text="1">
                </asp:TextBox>
                <asp:Button 
                    ID="btnAddItem" 
                    runat="server" 
                    Text="Add to Cart" 
                    OnClick="btnAddItem_Click" 
                    CssClass="btn btn-add" ValidationGroup="Quantity" />
                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="You can only buy 1 to 10 items" ForeColor="Red" MaximumValue="10" MinimumValue="1" Type="Integer" ValidationGroup="Quantity" ControlToValidate="txtQuantity"></asp:RangeValidator>&nbsp&nbsp&nbsp
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtQuantity" ValidationGroup="Quantity" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="summary-section">
            <div class="summary-row">
                <strong>Total Cart Amount:</strong>
                <asp:Label ID="lblTotalAmountCart" runat="server" Text="RM0.00" CssClass="summary-label"></asp:Label>
            </div>
            <asp:Label ID="lblMessage1" runat="server" CssClass="message-label"></asp:Label>
            <asp:Label ID="lblMessage2" runat="server" CssClass="message-label"></asp:Label>
            <asp:Button 
                ID="btnViewCart" 
                runat="server" 
                Text="View Cart" 
                OnClick="btnViewCart_Click" 
                CssClass="btn btn-view-cart" />
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="SELECT * FROM [Categories] ORDER BY [CatName]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="SELECT * FROM [Items] WHERE ([CatId] = @CatId)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCategory" Name="CatId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="spSalesGotItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSalesId" Name="salesid" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
