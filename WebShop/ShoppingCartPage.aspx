<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShoppingCartPage.aspx.cs"
    Inherits="ShoppingCartPage" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblShoppingCart" runat="server" Text="Shopping Cart" Visible="False"
            meta:resourcekey="lblShoppingCartResource1"></asp:Label></h2>
    <h3>
        <asp:Label ID="lblEditingOrder" runat="server" Text="Editing Order #" Visible="False"
            meta:resourcekey="lblEditingOrderResource1"></asp:Label>
    </h3>
    <asp:Label ID="lblEmpty" runat="server" Text="Shopping Cart Is Empty" meta:resourcekey="lblEmptyResource1"></asp:Label>
    <asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="False" StartNextButtonText="Place To Order"
        Visible="False" ActiveStepIndex="0" Width="100%" OnNextButtonClick="Wizard1_NextButtonClick"
        OnFinishButtonClick="Wizard1_FinishButtonClick" meta:resourcekey="Wizard1Resource1">
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" Title="Shopping Cart" AllowReturn="True"
                meta:resourcekey="WizardStep1Resource1">
                <asp:GridView ID="gridCart" runat="server" AutoGenerateColumns="False" BackColor="#FDFDF0"
                    Width="100%" AlternatingRowStyle-BackColor="#EEEEF0" HeaderStyle-BackColor="#EEEEF0"
                    BorderColor="#EEEEF0" BorderStyle="Solid" GridLines="None" DataKeyNames="ProductID"
                    meta:resourcekey="gridCartResource1" OnRowCommand="gridCart_RowCommand" 
                    OnRowDeleting="gridCart_RowDeleting">
                    <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField HeaderText="Product Name" DataField="Title" HeaderStyle-HorizontalAlign="Left"
                            meta:resourcekey="BoundFieldResource1">
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Unit Price" DataFormatString="{0:0.00}$" DataField="UnitPrice"
                            HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Quantity" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:TextBox ID="tbxQuantity" runat="server" Width="30px" Text='<%# Bind("Quantity") %>'
                                    meta:resourcekey="tbxQuantityResource1"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbxQuantity"
                                    ValidationExpression="\d" meta:resourcekey="RegularExpressionValidator1Resource1">*</asp:RegularExpressionValidator>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Total Price" DataField="TotalPrice" DataFormatString="{0:0.00}$"
                            HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3">
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnDelete" runat="server" Text="Delete" CommandName="Delete"
                                    CommandArgument='<%# Eval("ProductID") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
                </asp:GridView>
                <asp:Label ID="lblPrice" runat="server" Text="" meta:resourcekey="lblPriceResource1"></asp:Label>
                <br />
                <asp:Label ID="lblDiscount" runat="server" Text="" meta:resourcekey="lblDiscountResource1"></asp:Label>
                <br />
                <asp:Label ID="lblTotal" runat="server" Text="" meta:resourcekey="lblTotalResource1"></asp:Label>
                <br />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="BtnUpdate_OnClick"
                    meta:resourcekey="btnUpdateResource1" />
                <br />
                <asp:HyperLink ID="hlkAddProduct" runat="server" Text="Add Product" NavigateUrl="~/ShowProducts.aspx"
                    meta:resourcekey="hlkAddProductResource1" />
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="" meta:resourcekey="WizardStep2Resource1">
                <h2>
                    <asp:Label ID="lblFill" runat="server" Text="Fill This Form" meta:resourcekey="lblFillResource1"></asp:Label>
                </h2>
                <h3>
                </h3>
                <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" meta:resourcekey="DetailsView1Resource1">
                </asp:DetailsView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server"></asp:ObjectDataSource>
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
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" Text="Email:" meta:resourcekey="lblEmailResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbxEmail" runat="server" Width="98%" meta:resourcekey="tbxEmailResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAdress" runat="server" Text="Delivery Adress:" meta:resourcekey="lblAdressResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbxAdress" runat="server" TextMode="MultiLine" EnableTheming="True"
                                Rows="4" meta:resourcekey="tbxAdressResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblMethodOfrPayment" runat="server" Text="Method Of Payment: " Font-Bold="true"
                    meta:resourcekey="lblMethodOfrPaymentResource1"></asp:Label>
                <asp:DropDownList ID="ddlMethodOfPayment" runat="server" meta:resourcekey="ddlMethodOfPaymentResource1">
                    <asp:ListItem Text="Credit Card" Value="CreditCard" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    <asp:ListItem Text="Internal Method" Value="Internal" meta:resourcekey="ListItemResource2"></asp:ListItem>
                </asp:DropDownList>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep3" runat="server" Title="" meta:resourcekey="WizardStep3Resource1">
                <h2>
                    <asp:Label ID="lblOrderSummary" runat="server" Text="Order Summary" meta:resourcekey="lblOrderSummaryResource1"></asp:Label>
                </h2>
                <h3>
                </h3>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="First Name:" Font-Bold="true" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblFirstName2" runat="server" meta:resourcekey="lblFirstName2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Last Name:" Font-Bold="true" meta:resourcekey="Label2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblLastName2" runat="server" meta:resourcekey="lblLastName2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Telephone Number:" Font-Bold="true" meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblTelerhoneNum2" runat="server" meta:resourcekey="lblTelerhoneNum2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Email:" Font-Bold="true" meta:resourcekey="Label4Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblEmail2" runat="server" meta:resourcekey="lblEmail2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Delivery Adress:" Font-Bold="true" meta:resourcekey="Label5Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblDeliveryAddress2" runat="server" meta:resourcekey="lblDeliveryAddress2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Method Of Payment:" Font-Bold="true"
                                meta:resourcekey="Label6Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMethodOfPayment2" runat="server" meta:resourcekey="lblMethodOfPayment2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label7" runat="server" Text="Total:" Font-Bold="true" meta:resourcekey="Label7Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblTotal2" runat="server" meta:resourcekey="lblTotal2Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
</asp:Content>
