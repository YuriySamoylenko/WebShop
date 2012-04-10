<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyCheckBoxList.ascx.cs"
    Inherits="Controls_MyCheckBoxList" %>
<asp:CheckBoxList ID="chbxDepartments" runat="server" DataSourceID="odsDepartments"
    DataTextField="Title" DataValueField="ID" 
    OnSelectedIndexChanged="chbxDepartments_SelectedIndexChanged" 
    ondatabound="chbxDepartments_DataBound">
</asp:CheckBoxList>
<asp:ObjectDataSource ID="odsDepartments" runat="server" SelectMethod="GetDepartments"
    TypeName="BLL.Department"></asp:ObjectDataSource>
