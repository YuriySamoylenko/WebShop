<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="EditProfile.aspx.cs"
    Inherits="EditProfile" meta:resourcekey="PageResource1" %>

<%@ Register Src="Controls/ProfileControl.ascx" TagName="ProfileControl" TagPrefix="uc1" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:ProfileControl ID="ProfileControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
        <ContentTemplate>
            <asp:Label ID="lblScore" runat="server" Text="Your Score:" meta:resourcekey="lblScoreResource1"></asp:Label>
            <asp:Label ID="lblScoreValue" runat="server" meta:resourcekey="lblScoreValueResource1"></asp:Label>
            <br />
            <asp:LinkButton ID="btnRechargeScore" runat="server" Text="Recharge Score" OnClick="btnRechargeScore_Click"
                meta:resourcekey="btnRechargeScoreResource1" />
            <br />
            <asp:Label ID="lblEnterCode" runat="server" Text="Enter Code:" Visible="False" meta:resourcekey="lblEnterCodeResource1"></asp:Label>
            <asp:TextBox ID="tbxCode" runat="server" Visible="False" meta:resourcekey="tbxCodeResource1"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Field Is Required"
                ControlToValidate="tbxCode" Display="Dynamic" Visible="false"
                meta:resourcekey="RequiredFieldValidator1Resource1" ViewStateMode="Disabled"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Key"
                ControlToValidate="tbxCode" Display="Dynamic" ValidationExpression="[0-9A-Z]{10}"
                meta:resourcekey="RegularExpressionValidator1Resource1" Visible="false" ></asp:RegularExpressionValidator>
            <br />
            <p>
                <asp:Label ID="lblWrongKey" runat="server" Font-Bold="True" meta:resourcekey="lblWrongKeyResource1"></asp:Label></p>
            <asp:Button ID="btnEnterCode" runat="server" Text="Enter" OnClick="btnEnterCode_Click"
                Visible="False" meta:resourcekey="btnEnterCodeResource1" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="date">
        <asp:Label ID="lblUpdate" runat="server" Text="Profile updated successfully" Visible="False"
            meta:resourcekey="lblUpdateResource1"></asp:Label>
        <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" OnClick="btnUpdateProfile_Click"
            meta:resourcekey="btnUpdateProfileResource1" />
    </div>
</asp:Content>
