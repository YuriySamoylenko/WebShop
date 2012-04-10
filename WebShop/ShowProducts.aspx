<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShowProducts.aspx.cs"
    Inherits="ShowProducts" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Product Catalog" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblSelectDepartment" runat="server" Text="Select Department:" Font-Bold="True"
                    meta:resourcekey="lblSelectDepartmentResource1"></asp:Label>
                <asp:DropDownList ID="ddlDepartments" runat="server" AutoPostBack="True" DataSourceID="SourceDepartments"
                    DataTextField="Title" DataValueField="ID" AppendDataBoundItems="True" meta:resourcekey="ddlDepartmentsResource1">
                    <asp:ListItem Value="0" Text="All Departments" meta:resourcekey="ListItemResource1"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lblSorting" runat="server" Text="Sort By:" Font-Bold="True" meta:resourcekey="lblSortingResource1"></asp:Label>
                <asp:DropDownList ID="ddlSorting" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSorting_SelectedIndexChanged"
                    meta:resourcekey="ddlSortingResource1">
                    <asp:ListItem Text="By Title" Value="Title" meta:resourcekey="ListItemResource2"></asp:ListItem>
                    <asp:ListItem Text="By Total Raiting" Value="TotalRaiting" meta:resourcekey="ListItemResource3">
                    </asp:ListItem>
                    <asp:ListItem Text="By Added Date" Value="AddedDate" meta:resourcekey="ListItemResource4"></asp:ListItem>
                    <asp:ListItem Text="By Price" Value="UnitPrice" meta:resourcekey="ListItemResource6"></asp:ListItem>
                    <asp:ListItem Text="By Discount" Value="DiscountPercentage" meta:resourcekey="ListItemResource7"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label ID="lblOrder" runat="server" Text="Order By:" Font-Bold="True" meta:resourcekey="lblOrderResource1"></asp:Label>
                <asp:DropDownList ID="ddlOrder" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSorting_SelectedIndexChanged"
                    meta:resourcekey="ddlOrderResource1">
                    <asp:ListItem Text="Ascending" Value=" ASC" Selected="True" meta:resourcekey="ListItemResource8"></asp:ListItem>
                    <asp:ListItem Text="Descending" Value=" DESC" meta:resourcekey="ListItemResource9"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="SourceDepartments" runat="server" SelectMethod="GetDepartments"
        TypeName="BLL.Department"></asp:ObjectDataSource>
    <asp:GridView ID="gridProducts" runat="server" AutoGenerateColumns="False" DataSourceID="SourceProducts"
        GridLines="None" DataKeyNames="ID" BackColor="#FDFDF0" Width="100%" AlternatingRowStyle-BackColor="#EEEEF0"
        HeaderStyle-BackColor="#EEEEF0" BorderColor="#EEEEF0" BorderStyle="Solid" AllowPaging="True"
        meta:resourcekey="gridProductsResource1">
        <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                        NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                        meta:resourcekey="hlkTitleResource1"></asp:HyperLink>
                    <br />
                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Added Date" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource3">
                <ItemTemplate>
                    <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                        meta:resourcekey="lblAddedDateResource1"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Price" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource4">
                <ItemTemplate>
                    <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                        meta:resourcekey="lblUnitPriceResource1"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource5">
                <ItemTemplate>
                    <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                        meta:resourcekey="lblDiscountResource1"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rating" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource6">
                <ItemTemplate>
                    <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                        meta:resourcekey="lblTotalRaitingResource1"></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
    </asp:GridView>
    <asp:ObjectDataSource ID="SourceProducts" runat="server" SelectMethod="GetProductsByDepartment"
        TypeName="BLL.Product">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlDepartments" DefaultValue="0" Name="departmentID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlSorting" DefaultValue="" Name="sortExpression"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddlOrder" Name="order" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
