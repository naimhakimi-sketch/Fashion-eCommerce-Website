<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="SalesCart.aspx.cs" Inherits="ProjectAppWeb.SalesCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/StyleSheet1.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sales-container">
        <h4 class="section-header">Sales Cart</h4>
        <div class="row mb-3">
            <div class="col-auto">
                <span class="info-label">Sales id:</span>
                <asp:Label ID="lblSalesId" runat="server" CssClass="text-info"></asp:Label>
            </div>
            <div class="col-auto">
                <span class="info-label">Date and Time:</span>
                <asp:Label ID="lblDateTime" runat="server" CssClass="text-info"></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCart" CssClass="item-table">
                    <Columns>
                        <asp:BoundField DataField="ItemId" HeaderText="ItemId" SortExpression="ItemId" />
                        <asp:BoundField DataField="ItemTitle" HeaderText="Item" SortExpression="ItemTitle" />
                        <asp:BoundField DataField="ItemPrice" DataFormatString="RM {0}" HeaderText="Price" SortExpression="ItemPrice" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                        <asp:BoundField DataField="SubTotal" DataFormatString="RM {0}" HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-auto">
                <span class="info-label">Total amount:</span>
                <asp:Label ID="lblTotalAmountCart" runat="server" Text="RM0.00" CssClass="text-success"></asp:Label>
            </div>
        </div>

        <div class="row action-row">
            <div class="col-auto">
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Sales" OnClick="btnConfirm_Click" CssClass="btn btn-add" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel Sales" OnClick="btnCancel_Click" CssClass="btn btn-danger ms-2" />
                <asp:Button ID="btnNew" runat="server" Text="New Sales" OnClick="btnNew_Click" CssClass="btn btn-view-cart ms-2" />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <asp:Label ID="lblMessage2" runat="server" CssClass="text-info"></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <div class="card shadow-sm" id="summaryCard">
                    <div class="card-body">
                        <h5 class="card-title">Summary</h5>
                        <p class="card-text">
                            <span class="info-label">Total Amount:</span>
                            <asp:Label ID="lblTotalAmount" runat="server"></asp:Label><br />
                            <span class="info-label">Service Tax:</span>
                            <asp:Label ID="lblServiceTax" runat="server"></asp:Label><br />
                            <span class="info-label">Amount After Tax:</span>
                            <asp:Label ID="lblAmountAfterTax" runat="server"></asp:Label><br />
                            <span class="info-label">Rounding:</span>
                            <asp:Label ID="lblRounding" runat="server"></asp:Label><br />
                            <span class="info-label">Amount Rounded:</span>
                            <asp:Label ID="lblAmountRounded" runat="server"></asp:Label><br />
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <asp:SqlDataSource ID="SqlDataSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:DataBase %>" SelectCommand="spSalesGotItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblSalesId" Name="salesid" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
