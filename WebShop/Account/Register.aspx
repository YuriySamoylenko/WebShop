<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" meta:resourcekey="PageResource1" %>

<%@ Register Src="../Controls/ProfileControl.ascx" TagName="ProfileControl" TagPrefix="uc1" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="False" OnCreatedUser="RegisterUser_CreatedUser"
        OnFinishButtonClick="RegisterUser_FinishButtonClick" meta:resourcekey="RegisterUserResource1">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server" Title="" meta:resourcekey="RegisterUserWizardStepResource1">
                <ContentTemplate>
                    <h2>
                        <asp:Label ID="lblCreate" runat="server" Text="Create a New Account" meta:resourcekey="lblCreateResource1"></asp:Label>
                    </h2>
                    <p>
                        <asp:Label ID="lblUseForm" runat="server" Text="Use the form below to create a new account."
                            meta:resourcekey="lblUseFormResource1"></asp:Label>
                    </p>
                    <p>
                        <asp:Label ID="lblRequired" runat="server" Text="Passwords are required to be a minimum of"
                            meta:resourcekey="lblRequiredResource1"></asp:Label>
                        <asp:Label ID="lblLength" runat="server" Text="characters in length." meta:resourcekey="lblLengthResource1"></asp:Label>
                    </p>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" meta:resourcekey="UserNameLabelResource1">User Name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server" meta:resourcekey="UserNameResource1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="RegisterUser"
                                    meta:resourcekey="UserNameRequiredResource1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" meta:resourcekey="PasswordLabelResource1">Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" meta:resourcekey="PasswordResource1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="RegisterUser"
                                    meta:resourcekey="PasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Password"
                                    ErrorMessage="Passwords are required to be a minimum of 6 characters in length."
                                    ValidationGroup="RegisterUser" ValidationExpression="\w+" meta:resourcekey="RegularExpressionValidator1Resource1">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword"
                                    meta:resourcekey="ConfirmPasswordLabelResource1">Confirm Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" meta:resourcekey="ConfirmPasswordResource1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                    ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                    ValidationGroup="RegisterUser" meta:resourcekey="ConfirmPasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                    ControlToValidate="ConfirmPassword" ErrorMessage="The Password and Confirmation Password must match."
                                    ValidationGroup="RegisterUser" meta:resourcekey="PasswordCompareResource1">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" meta:resourcekey="EmailLabelResource1">E-mail:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Email" runat="server" meta:resourcekey="EmailResource1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                    ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="RegisterUser"
                                    meta:resourcekey="EmailRequiredResource1">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Email"
                                    ErrorMessage="Incorrect Email" ValidationGroup="RegisterUser" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    meta:resourcekey="RegularExpressionValidator2Resource1">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCaptcha" runat="server" AssociatedControlID="Email" Text="Security Code:"
                                    meta:resourcekey="lblCaptchaResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="tbxCaptcha" runat="server" meta:resourcekey="tbxCaptchaResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Seqirity Code is Required."
                                            ControlToValidate="tbxCaptcha" ValidationGroup="RegisterUser" meta:resourcekey="RequiredFieldValidator1Resource1"
                                            Display="Dynamic">*</asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="" ControlToValidate="tbxCaptcha"
                                            meta:resourcekey="CompareValidator1Resource1" ValidationGroup="RegisterUser"
                                            Display="Dynamic">*</asp:CompareValidator>
                                        <asp:Image ID="imgCaptcha" runat="server" ImageUrl="~/Captcha.ashx" meta:resourcekey="imgCaptchaResource1" />
                                        <asp:Label ID="lblSample" runat="server" Text=""></asp:Label>
                                        <asp:Button ID="btnCaptcha" runat="server" Text="Update Image" OnClick="btnCaptcha_Click"
                                            meta:resourcekey="btnCaptchaResource1" Visible="false" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" ValidationGroup="RegisterUser"
                        meta:resourcekey="RegisterUserValidationSummaryResource1" />
                </ContentTemplate>
            </asp:CreateUserWizardStep>
            <asp:WizardStep ID="ProfileInfo" runat="server" meta:resourcekey="ProfileInfoResource1">
                <uc1:ProfileControl ID="ProfileControl1" runat="server" />
            </asp:WizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" meta:resourcekey="CompleteWizardStep1Resource1">
                <ContentTemplate>
                    <h2>
                        <asp:Label ID="lblComplete" runat="server" Text="Complete" meta:resourcekey="lblCompleteResource1"></asp:Label>
                    </h2>
                    <h3>
                        <asp:Label ID="lblCreated" runat="server" Text="Your account has been successfully created."
                            meta:resourcekey="lblCreatedResource1"></asp:Label>
                    </h3>
                    <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue"
                        Text="Continue" ValidationGroup="RegisterUser" meta:resourcekey="ContinueButtonResource1" />
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
