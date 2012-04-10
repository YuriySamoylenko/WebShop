<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="EditOrder.aspx.cs"
    Inherits="Admin_EditOrder" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Edit Order" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="100%" AutoGenerateRows="False"
        DataSourceID="ObjectDataSource1" GridLines="None" HeaderStyle-BackColor="#3F4040"
        HeaderStyle-ForeColor="White" HeaderText="Order Details" BackColor="#FDFDF0"
        DataKeyNames="ID" meta:resourcekey="DetailsView1Resource1">
        <Fields>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                meta:resourcekey="BoundFieldResource1" />
            <asp:BoundField DataField="AddedDate" HeaderText="AddedDate" ReadOnly="True" SortExpression="AddedDate"
                meta:resourcekey="BoundFieldResource2" />
            <asp:BoundField DataField="AddedBy" HeaderText="AddedBy" ReadOnly="True" SortExpression="AddedBy"
                meta:resourcekey="BoundFieldResource3" />
            <asp:BoundField HeaderText="Status" DataField="StatusTitle" meta:resourcekey="BoundFieldResource4" />
            <asp:BoundField DataField="MethodOfPayment" HeaderText="MethodOfPayment" ReadOnly="True"
                SortExpression="MethodOfPayment" meta:resourcekey="BoundFieldResource5" />
            <asp:BoundField DataFormatString="{0:0.00}$" DataField="SubTotal" HeaderText="Total"
                ReadOnly="True" SortExpression="SubTotal" meta:resourcekey="BoundFieldResource6" />
            <asp:BoundField DataField="DeliveryAddress" HeaderText="DeliveryAddress" ReadOnly="True"
                SortExpression="DeliveryAddress" meta:resourcekey="BoundFieldResource7" />
            <asp:BoundField DataField="CustomerEmail" HeaderText="CustomerEmail" ReadOnly="True"
                SortExpression="CustomerEmail" meta:resourcekey="BoundFieldResource8" />
            <asp:BoundField DataField="CustomerPhone" HeaderText="CustomerPhone" ReadOnly="True"
                SortExpression="CustomerPhone" meta:resourcekey="BoundFieldResource9" />
            <asp:BoundField DataField="Paid" HeaderText="Is Paid" ReadOnly="true" meta:resourcekey="BoundFieldResource10" />
        </Fields>
        <HeaderStyle BackColor="#3F4040" ForeColor="White"></HeaderStyle>
    </asp:DetailsView>
    <asp:Label ID="lblStatus" runat="server" Text="Select New Status: " Font-Bold="True"
        meta:resourcekey="lblStatusResource1"></asp:Label>
    <asp:DropDownList ID="ddlStatuses" runat="server" AutoPostBack="True" DataSourceID="sourceStatuses"
        DataTextField="Title" DataValueField="ID" meta:resourcekey="ddlStatusesResource1">
    </asp:DropDownList>
    <asp:Button ID="btnChangeStatus" runat="server" Text="Change Status" OnClick="btnChangeStatus_Click"
        meta:resourcekey="btnChangeStatusResource1" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DeleteOrder"
        SelectMethod="GetOrderByID" TypeName="BLL.Order" 
        UpdateMethod="UpdateOrder">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="orderID" QueryStringField="orderID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="id" Type="Int32" />
            <asp:Parameter Name="statusID" Type="Int32" />
            <asp:Parameter Name="shippedDate" Type="DateTime" />
            <asp:Parameter Name="transactionID" Type="String" />
            <asp:Parameter Name="trackingID" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="sourceStatuses" runat="server" SelectMethod="GetOrderSatuses"
        TypeName="BLL.OrderStatus"></asp:ObjectDataSource>
    <br />
    <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1" Visible="false"></asp:Label>
</asp:Content>
