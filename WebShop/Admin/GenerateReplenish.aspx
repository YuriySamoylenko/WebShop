<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="GenerateReplenish.aspx.cs"
    Inherits="Admin_GenerateReplenish" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Generate Replenish Key" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblAmount" runat="server" Text="Enter Amount For Replehish:" Font-Bold="True"
                    meta:resourcekey="lblAmountResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxAmount" runat="server" meta:resourcekey="tbxAmountResource1"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Field Is Required"
                    ControlToValidate="tbxAmount" Display="Dynamic" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Format"
                    ControlToValidate="tbxAmount" ValidationExpression="\d+,\d{2}" Display="Dynamic"
                    meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate Key" OnClick="btnGenerate_Click"
                    meta:resourcekey="btnGenerateResource1"  />
            </td>
            <td>
                <asp:TextBox ID="tbxKey" runat="server" ReadOnly="True" meta:resourcekey="tbxKeyResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblUsers" runat="server" Text="Select User:" Font-Bold="True" meta:resourcekey="lblUsersResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlUsers" runat="server" meta:resourcekey="ddlUsersResource1"
                    DataSourceID="odsUsers" DataTextField="UserName" DataValueField="UserName">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsUsers" runat="server" SelectMethod="GetUsers" 
                    TypeName="BLL.Servise">
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="btnSendKey" runat="server" Text="Send Key To User" OnClick="btnSendKey_Click"
                Enabled="False" meta:resourcekey="btnSendKeyResource1" />
            <br />
            <asp:Label ID="lblResult" runat="server" Text="" Visible="false"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
