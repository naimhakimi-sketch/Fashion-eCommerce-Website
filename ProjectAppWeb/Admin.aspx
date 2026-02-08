<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ProjectAppWeb.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/StyleSheet1.css" rel="stylesheet" />
    <link href="Styles/sign-in.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" 
        DeleteCommand="DELETE FROM [UserAccount] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [UserAccount] ([UserName], [PasswordHash], [Role], [Enable]) VALUES (@UserName, @PasswordHash, @Role, @Enable)" 
        SelectCommand="SELECT * FROM [UserAccount]" 
        UpdateCommand="UPDATE [UserAccount] SET [UserName] = @UserName, [PasswordHash] = @PasswordHash, [Role] = @Role, [Enable] = @Enable WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enable" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enable" Type="Boolean" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="container">
        <h1 class="page-header">Admin Page</h1>
        <h2 class="section-header">Users</h2>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                <asp:BoundField DataField="PasswordHash" HeaderText="Password Hash" SortExpression="PasswordHash" />
                <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                <asp:TemplateField HeaderText="Enable">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkEnable" runat="server" Checked='<%# Bind("Enable") %>' Enabled="false" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkEnableEdit" runat="server" Checked='<%# Bind("Enable") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <h2 class="section-header">Sales</h2>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="spGetSalesWithCombinedItems" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="SalesId" HeaderText="Sales ID" SortExpression="SalesId" />
                <asp:BoundField DataField="CombinedItemIds" HeaderText="Items ID" SortExpression="CombinedItemIds" ReadOnly="True" />
                <asp:BoundField DataField="TotalQuantity" HeaderText="Total Quantity" SortExpression="TotalQuantity" ReadOnly="True" />
                <asp:BoundField DataField="SalesDate" HeaderText="Sales Date" ReadOnly="True" SortExpression="SalesDate" />
                <asp:BoundField DataField="UserName" HeaderText="User" ReadOnly="True" SortExpression="UserName" />
            </Columns>
        </asp:GridView>
        
        <h2 class="section-header">Items</h2>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" 
            SelectCommand="SELECT * FROM [Items]"
            DeleteCommand="DELETE FROM [Items] WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))" InsertCommand="INSERT INTO [Items] ([CatId], [ItemTitle], [ItemPrice], [ItemDesc], [ItemImage]) VALUES (@CatId, @ItemTitle, @ItemPrice, @ItemDesc, @ItemImage)" UpdateCommand="UPDATE [Items] SET [CatId] = @CatId, [ItemTitle] = @ItemTitle, [ItemPrice] = @ItemPrice, [ItemDesc] = @ItemDesc, [ItemImage] = @ItemImage WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
            <DeleteParameters>
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <div class="col-md-4">
            <span class="fw-bold">Select category: </span>
            <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="SqlDataSource4" DataTextField="CatName" DataValueField="CatId" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="form-select mt-2">
                <asp:ListItem Text="All" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <br />
        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemId" CssClass="table table-striped table-bordered" DataSourceID="SqlDataSource3" style="margin-top: 0px">
            <Columns>
                <asp:BoundField DataField="ItemId" HeaderText="ItemId" SortExpression="ItemId" ReadOnly="True" InsertVisible="False" />
                <asp:BoundField DataField="CatId" HeaderText="CatId" SortExpression="CatId" />
                <asp:BoundField DataField="ItemTitle" HeaderText="ItemTitle" SortExpression="ItemTitle"/>
                <asp:BoundField DataField="ItemPrice" HeaderText="ItemPrice" SortExpression="ItemPrice" />
                <asp:BoundField DataField="ItemDesc" HeaderText="ItemDesc" SortExpression="ItemDesc" />
                <asp:BoundField DataField="ItemImage" HeaderText="ItemImage" SortExpression="ItemImage" />
            </Columns>
        </asp:GridView>

        <h2 class="section-header">Items List View</h2>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DataBase %>" DeleteCommand="DELETE FROM [Items] WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))" InsertCommand="INSERT INTO [Items] ([CatId], [ItemTitle], [ItemPrice], [ItemDesc], [ItemImage]) VALUES (@CatId, @ItemTitle, @ItemPrice, @ItemDesc, @ItemImage)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Items]" UpdateCommand="UPDATE [Items] SET [CatId] = @CatId, [ItemTitle] = @ItemTitle, [ItemPrice] = @ItemPrice, [ItemDesc] = @ItemDesc, [ItemImage] = @ItemImage WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DataBase %>" DeleteCommand="DELETE FROM [Items] WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))" InsertCommand="INSERT INTO [Items] ([CatId], [ItemTitle], [ItemPrice], [ItemDesc], [ItemImage]) VALUES (@CatId, @ItemTitle, @ItemPrice, @ItemDesc, @ItemImage)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Items]" UpdateCommand="UPDATE [Items] SET [CatId] = @CatId, [ItemTitle] = @ItemTitle, [ItemPrice] = @ItemPrice, [ItemDesc] = @ItemDesc, [ItemImage] = @ItemImage WHERE [ItemId] = @original_ItemId AND [CatId] = @original_CatId AND (([ItemTitle] = @original_ItemTitle) OR ([ItemTitle] IS NULL AND @original_ItemTitle IS NULL)) AND (([ItemPrice] = @original_ItemPrice) OR ([ItemPrice] IS NULL AND @original_ItemPrice IS NULL)) AND (([ItemDesc] = @original_ItemDesc) OR ([ItemDesc] IS NULL AND @original_ItemDesc IS NULL)) AND (([ItemImage] = @original_ItemImage) OR ([ItemImage] IS NULL AND @original_ItemImage IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="CatId" Type="Int32" />
                <asp:Parameter Name="ItemTitle" Type="String" />
                <asp:Parameter Name="ItemPrice" Type="Double" />
                <asp:Parameter Name="ItemDesc" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
                <asp:Parameter Name="original_ItemId" Type="Int32" />
                <asp:Parameter Name="original_CatId" Type="Int32" />
                <asp:Parameter Name="original_ItemTitle" Type="String" />
                <asp:Parameter Name="original_ItemPrice" Type="Double" />
                <asp:Parameter Name="original_ItemDesc" Type="String" />
                <asp:Parameter Name="original_ItemImage" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ItemId" DataSourceID="SqlDataSource6" InsertItemPosition="LastItem" >
            <AlternatingItemTemplate>
                <tr style="" CssClass="table table-striped table-bordered">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="ItemIdLabel" runat="server" Text='<%# Eval("ItemId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CatIdLabel" runat="server" Text='<%# Eval("CatId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemTitleLabel" runat="server" Text='<%# Eval("ItemTitle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemPriceLabel" runat="server" Text='<%# Eval("ItemPrice") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemDescLabel" runat="server" Text='<%# Eval("ItemDesc") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemImageLabel" runat="server" Text='<%# Eval("ItemImage") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="" CssClass="table table-striped table-bordered">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    </td>
                    <td >
                        <asp:Label ID="ItemIdLabel1" runat="server" Text='<%# Eval("ItemId") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="CatIdTextBox" runat="server" Text='<%# Bind("CatId") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemTitleTextBox" runat="server" Text='<%# Bind("ItemTitle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemPriceTextBox" runat="server" Text='<%# Bind("ItemPrice") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemDescTextBox" runat="server" Text='<%# Bind("ItemDesc") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemImageTextBox" runat="server" Text='<%# Bind("ItemImage") %>' />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="" CssClass="table table-striped table-bordered">
                    <tr CssClass="table table-striped table-bordered">
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="" CssClass="table table-striped table-bordered">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:TextBox ID="CatIdTextBox" runat="server" Text='<%# Bind("CatId") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemTitleTextBox" runat="server" Text='<%# Bind("ItemTitle") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemPriceTextBox" runat="server" Text='<%# Bind("ItemPrice") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemDescTextBox" runat="server" Text='<%# Bind("ItemDesc") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="ItemImageTextBox" runat="server" Text='<%# Bind("ItemImage") %>' />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="" CssClass="table table-striped table-bordered">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="ItemIdLabel" runat="server" Text='<%# Eval("ItemId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CatIdLabel" runat="server" Text='<%# Eval("CatId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemTitleLabel" runat="server" Text='<%# Eval("ItemTitle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemPriceLabel" runat="server" Text='<%# Eval("ItemPrice") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemDescLabel" runat="server" Text='<%# Eval("ItemDesc") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemImageLabel" runat="server" Text='<%# Eval("ItemImage") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server" CssClass="table table-striped table-bordered">
                    <tr runat="server" CssClass="table table-striped table-bordered">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr runat="server" style="" CssClass="table table-striped table-bordered">
                                    <th runat="server"></th>
                                    <th runat="server">ItemId</th>
                                    <th runat="server">CatId</th>
                                    <th runat="server">ItemTitle</th>
                                    <th runat="server">ItemPrice</th>
                                    <th runat="server">ItemDesc</th>
                                    <th runat="server">ItemImage</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server" CssClass="table table-striped table-bordered">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server" CssClass="table table-striped table-bordered">
                        <td runat="server" style="">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="" CssClass="table table-striped table-bordered">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="ItemIdLabel" runat="server" Text='<%# Eval("ItemId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="CatIdLabel" runat="server" Text='<%# Eval("CatId") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemTitleLabel" runat="server" Text='<%# Eval("ItemTitle") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemPriceLabel" runat="server" Text='<%# Eval("ItemPrice") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemDescLabel" runat="server" Text='<%# Eval("ItemDesc") %>' />
                    </td>
                    <td>
                        <asp:Label ID="ItemImageLabel" runat="server" Text='<%# Eval("ItemImage") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
    </div>

    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="SELECT * FROM [Categories] ORDER BY [CatName]"></asp:SqlDataSource>
    </asp:Content>
