<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProfileControl.ascx.cs"
    Inherits="Controls_ProfileControl" %>
<div>
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Data of your profile." meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <table>
        <tr>
            <td>
                <asp:Label ID="lblFirstName" runat="server" Text="First Name:" meta:resourcekey="lblFirstNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxFirstName" runat="server" Width="98%" meta:resourcekey="tbxFirstNameResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblLastName" runat="server" Text="Last Name:" meta:resourcekey="lblLastNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxLastName" runat="server" Width="98%" meta:resourcekey="tbxLastNameResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblTelNum" runat="server" Text="Telephone Number:" meta:resourcekey="lblTelNumResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxTelNum" runat="server" Width="98%" meta:resourcekey="tbxTelNumResource1"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid format"
                    ControlToValidate="tbxTelNum" ValidationExpression="\(\d{3}\)-\d{3}-\d{2}-\d{2}"
                    Display="Dynamic" meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblAdress" runat="server" Text="Address:" meta:resourcekey="lblAdressResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxAdress" runat="server" TextMode="MultiLine" EnableTheming="True"
                    Rows="4" meta:resourcekey="tbxAdressResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblSelLang" runat="server" Text="Select Language" meta:resourcekey="lblSelLangResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlLanguage" runat="server" meta:resourcekey="ddlLanguageResource1">
                    <asp:ListItem meta:resourcekey="ListItemResource1" Value="en">English</asp:ListItem>
                    <asp:ListItem meta:resourcekey="ListItemResource2" Value="ru">Russian</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</div>
