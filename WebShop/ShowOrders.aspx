<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShowOrders.aspx.cs"
    Inherits="ShowOrders" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Your Orders" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="1">
        <asp:View ID="View1" runat="server">
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                GridLines="None" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0" BorderStyle="Solid"
                AllowPaging="True" DataKeyNames="ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                SelectedIndex="0" meta:resourcekey="GridView1Resource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField HeaderText="Order ID" DataField="ID" meta:resourcekey="BoundFieldResource1">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Added Date" DataField="AddedDate" meta:resourcekey="BoundFieldResource2">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Status" DataField="StatusTitle" meta:resourcekey="BoundFieldResource3">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Total" DataFormatString="{0:0.00}$" DataField="SubTotal"
                        meta:resourcekey="BoundFieldResource4">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:BoundField>
                    <asp:CommandField ShowSelectButton="True" meta:resourcekey="CommandFieldResource1" />
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetOrdersByCustomer"
                TypeName="BLL.Order">
                <SelectParameters>
                    <asp:QueryStringParameter Name="customerName" QueryStringField="userName" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </asp:View>
    </asp:MultiView>
</asp:Content>
