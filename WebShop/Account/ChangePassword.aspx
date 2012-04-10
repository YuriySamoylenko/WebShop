<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="Account_ChangePassword" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Change Password" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="lblUseForm" runat="server" Text="Use the form below to change your password."
            meta:resourcekey="lblUseFormResource1"></asp:Label>
    </p>
    <p>
        <asp:Label ID="lblMinmum" runat="server" 
            Text="New passwords are required to be a minimum of" 
            meta:resourcekey="lblMinmumResource1"></asp:Label>
        <%= Membership.MinRequiredPasswordLength %>
        <asp:Label ID="lblLength" runat="server" Text="characters in length." 
            meta:resourcekey="lblLengthResource1"></asp:Label>
    </p>
    <asp:ChangePassword ID="ChangeUserPassword" runat="server" SuccessPageUrl="ChangePasswordSuccess.aspx"
        meta:resourcekey="ChangeUserPasswordResource1">
    </asp:ChangePassword>
</asp:Content>
