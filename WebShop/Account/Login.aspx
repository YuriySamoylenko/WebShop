<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Account_Login" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Log In" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="lblEnter" runat="server" Text="Please enter your username and password."
            meta:resourcekey="lblEnterResource1"></asp:Label>
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="False" NavigateUrl="~/Account/Register.aspx"
            Text="Register " meta:resourcekey="RegisterHyperLinkResource1"></asp:HyperLink>
        <asp:Label ID="lblIf" runat="server" Text="if you don't have an account." meta:resourcekey="lblIfResource1"></asp:Label>
    </p>
    <asp:Login ID="LoginUser" runat="server" TitleText="" 
        meta:resourcekey="LoginUserResource1" onloggedin="LoginUser_LoggedIn">
    </asp:Login>
</asp:Content>
