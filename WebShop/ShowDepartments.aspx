<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShowDepartments.aspx.cs"
    Inherits="ShowDepartment" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Departments" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <asp:GridView ID="gridDepartments" runat="server" DataSourceID="sourceDepartments"
        AutoGenerateColumns="False" AllowPaging="True" ShowHeader="False" BackColor="#FDFDF0"
        Width="100%" AlternatingRowStyle-BackColor="#EEEEF0" HeaderStyle-BackColor="#EEEEF0"
        BorderColor="#EEEEF0" BorderStyle="Solid" GridLines="None" meta:resourcekey="gridDepartmentsResource1">
        <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' NavigateUrl='<%# "ShowProducts.aspx?id=" + Eval("ID") %>'
                        meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProducts.aspx?id=" + Eval("ID") %>'
                        meta:resourcekey="hlkTitleResource1"></asp:HyperLink>
                    <br />
                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
    </asp:GridView>
    <asp:ObjectDataSource ID="sourceDepartments" runat="server" SelectMethod="GetDepartments"
        TypeName="BLL.Department"></asp:ObjectDataSource>
</asp:Content>
