<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePasswordSuccess.aspx.cs" Inherits="Account_ChangePasswordSuccess" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Change Password" 
            meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="lblPasswordChanged" runat="server" 
            Text="Your password has been changed successfully." 
            meta:resourcekey="lblPasswordChangedResource1"></asp:Label>
    </p>
</asp:Content>
