<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShowProduct.aspx.cs"
    Inherits="ShowProduct" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="SourceProduct" DataKeyNames="ID"
        Width="100%" HeaderText="Product Details" meta:resourcekey="FormView1Resource1">
        <HeaderStyle BackColor="#3F4040" ForeColor="White" />
        <ItemTemplate>
            <div>
                <h2>
                    <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' Font-Bold="True"
                        meta:resourcekey="lblTitleResource1"></asp:Label></h2>
                <p>
                </p>
                <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                    Target="_blank" NavigateUrl='<%# Eval("FullImageUrl") %>' CssClass="floatLeft"
                    meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
            </div>
            <div class="clear">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblHeadPeice" runat="server" Text="Price:" Font-Bold="True" meta:resourcekey="lblHeadPeiceResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblPriceResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblHeadDiscount" runat="server" Text="Discount:" Font-Bold="True"
                                meta:resourcekey="lblHeadDiscountResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                                meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Price With Discount:" Font-Bold="True"
                                meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("FinalUnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="Label2Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Added Dete:" Font-Bold="True" meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>' meta:resourcekey="Label4Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Units In Stock" Font-Bold="True" meta:resourcekey="Label5Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("UnitsInStock") %>' meta:resourcekey="Label6Resource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" OnClick="btnAddToCart_Click"
        meta:resourcekey="btnAddToCartResource1" />
    <asp:ObjectDataSource ID="SourceProduct" runat="server" SelectMethod="GetProductByID"
        TypeName="BLL.Product">
        <SelectParameters>
            <asp:QueryStringParameter Name="productID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblOverLimit" runat="server" meta:resourcekey="lblOverLimitResource1"></asp:Label>
</asp:Content>
