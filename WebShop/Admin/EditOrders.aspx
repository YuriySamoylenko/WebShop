<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="EditOrders.aspx.cs"
    Inherits="Admin_EditOrders" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mpart">
        <h2>
            <asp:Label ID="lblHeader" runat="server" Text="Edit Orders" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </h2>
        <h3>
        </h3>
        <p>
            <asp:Label ID="lblOrdersBy" runat="server" Text="Get Orders By:" meta:resourcekey="lblOrdersByResource1"></asp:Label>
        </p>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Customer:" meta:resourcekey="Label1Resource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbxCustomer" runat="server" meta:resourcekey="tbxCustomerResource1"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnCustomerLoad" runat="server" Text="Load" OnClick="btnCustomerLoad_Click"
                        meta:resourcekey="btnCustomerLoadResource1" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="ID:" meta:resourcekey="Label2Resource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbxID" runat="server" meta:resourcekey="tbxIDResource1"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnIDLoad" runat="server" Text="Load" OnClick="btnIDLoad_Click" meta:resourcekey="btnIDLoadResource1" />
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None"
            AlternatingRowStyle-BackColor="#EEEEF0" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0"
            BorderStyle="Solid" HeaderStyle-BackColor="#EEEEF0" meta:resourcekey="GridView1Resource1">
            <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField HeaderText="ID" DataField="ID" HeaderStyle-HorizontalAlign="Left"
                    meta:resourcekey="BoundFieldResource1">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Added Date" DataField="AddedDate" HeaderStyle-HorizontalAlign="Left"
                    meta:resourcekey="BoundFieldResource2">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Customer" DataField="AddedBy" HeaderStyle-HorizontalAlign="Left"
                    meta:resourcekey="BoundFieldResource3">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Status" DataField="StatusTitle" HeaderStyle-HorizontalAlign="Left"
                    meta:resourcekey="BoundFieldResource4">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Total" DataField="SubTotal" HeaderStyle-HorizontalAlign="Left"
                    DataFormatString="{0:0.00}$" meta:resourcekey="BoundFieldResource5">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:HyperLinkField Text="Select" DataNavigateUrlFormatString="~/Admin/EditOrder.aspx?orderID={0}"
                    DataNavigateUrlFields="ID" meta:resourcekey="HyperLinkFieldResource1" />
            </Columns>
            <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
        </asp:GridView>
    </div>
</asp:Content>
