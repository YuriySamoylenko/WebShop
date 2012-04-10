<%@ Page Language="C#" AutoEventWireup="true" Title="Web Shop : Admin" MasterPageFile="~/Site.Master"
    CodeFile="Admin.aspx.cs" Inherits="Admin_Admin" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mpart">
        <h2>
            <asp:Label ID="lblHeader" runat="server" Text="Admin" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </h2>
        <h3>
        </h3>
        <div class="">
            <asp:HyperLink runat="server" ID="hlkEditDepartments" NavigateUrl="~/Admin/EditDepartments.aspx"
                Text="Edit Departmens" meta:resourcekey="hlkEditDepartmentsResource1"></asp:HyperLink>
            <br />
            <asp:HyperLink ID="hlkEditProducts" runat="server" NavigateUrl="~/Admin/AddProduct.aspx"
                Text="Edit Products" meta:resourcekey="hlkEditProductsResource1"></asp:HyperLink>
            <br />
            <asp:HyperLink ID="hlkEditOrders" runat="server" NavigateUrl="~/Admin/EditOrders.aspx"
                Text="Edit Orders" meta:resourcekey="hlkEditOrdersResource1"></asp:HyperLink>
            <br />
            <asp:HyperLink ID="hlkViewReports" runat="server" NavigateUrl="~/Admin/ViewReports.aspx"
                Text="View Reports" meta:resourcekey="hlkViewReportsResource1"></asp:HyperLink>
            <br />
            <asp:HyperLink ID="hlkReplenish" runat="server" NavigateUrl="~/Admin/GenerateReplenish.aspx"
                Text="Generate Replenish Key" meta:resourcekey="hlkReplenishResource1"></asp:HyperLink>
        </div>
    </div>
</asp:Content>
