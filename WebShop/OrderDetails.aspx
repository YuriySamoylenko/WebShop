<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="OrderDetails.aspx.cs"
    Inherits="OrderDetails" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Order Details" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="100%" DataSourceID="odsOrder"
        GridLines="None" HeaderStyle-BackColor="#3F4040" HeaderStyle-ForeColor="White"
        HeaderText="Order Details" BackColor="#FDFDF0" AutoGenerateRows="False" DataKeyNames="ID"
        meta:resourcekey="DetailsView1Resource1">
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                meta:resourcekey="BoundFieldResource1" />
            <asp:BoundField DataField="AddedDate" HeaderText="AddedDate" ReadOnly="True" SortExpression="AddedDate"
                meta:resourcekey="BoundFieldResource2" />
            <asp:BoundField HeaderText="Status" DataField="StatusTitle" meta:resourcekey="BoundFieldResource3" />
            <asp:BoundField DataField="MethodOfPayment" HeaderText="MethodOfPayment" ReadOnly="True"
                SortExpression="MethodOfPayment" meta:resourcekey="BoundFieldResource4" />
            <asp:BoundField DataFormatString="{0:0.00}$" DataField="SubTotal" HeaderText="Total"
                ReadOnly="True" SortExpression="SubTotal" meta:resourcekey="BoundFieldResource5" />
            <asp:BoundField DataField="DeliveryAddress" HeaderText="DeliveryAddress" ReadOnly="True"
                SortExpression="DeliveryAddress" meta:resourcekey="BoundFieldResource6" />
            <asp:BoundField DataField="CustomerEmail" HeaderText="CustomerEmail" ReadOnly="True"
                SortExpression="CustomerEmail" meta:resourcekey="BoundFieldResource7" />
            <asp:BoundField DataField="CustomerPhone" HeaderText="CustomerPhone" ReadOnly="True"
                SortExpression="CustomerPhone" meta:resourcekey="BoundFieldResource8" />
            <asp:BoundField DataField="Paid" HeaderText="Is Paid" ReadOnly="true" meta:resourcekey="BoundFieldResource9" />
        </Fields>
        <HeaderStyle BackColor="#3F4040" ForeColor="White"></HeaderStyle>
    </asp:DetailsView>
    <asp:ObjectDataSource ID="odsOrder" runat="server" SelectMethod="GetOrderByID" 
        TypeName="BLL.Order">
        <SelectParameters>
            <asp:QueryStringParameter Name="orderID" QueryStringField="orderID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <table width="100%">
        <tr>
            <td>
                <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel Order" OnClick="btnCancelOrder_Click"
                    meta:resourcekey="btnCancelOrderResource1" />
            </td>
            <td>
                <asp:LinkButton ID="lnkbtnAddProduct" runat="server" OnClick="LinkButton1_Click"
                    Text="Add New Product In Order" meta:resourcekey="lnkbtnAddProductResource1"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnPayOrder" runat="server" Text="Pay The Order" OnClick="btnPayOrder_Click"
                    meta:resourcekey="btnPayOrderResource1" />
            </td>
            <td>
                <asp:Label ID="lblScore" runat="server" Text="Your Score:" meta:resourcekey="lblScoreResource1"></asp:Label>
                <asp:Label ID="lblScoreValue" runat="server" meta:resourcekey="lblScoreValueResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Label ID="lblNewLevel" runat="server" meta:resourcekey="lblNewLevelResource1"></asp:Label>
</asp:Content>
