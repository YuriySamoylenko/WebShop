<%@ Page Title="Web Shop Home Page" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="mpart">
        <p style="background: red; color: White">
            Admin Account: UserName: Admin/ Password:666666</p>
        <h2>
            <asp:Label ID="lblHeader" runat="server" Text="Home Page" Font-Bold="True" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </h2>
        <h3>
        </h3>
        <div>
            <h1>
                <asp:Label ID="lblHeader1" runat="server" Text="BEST SELLING PRODUCTS" meta:resourcekey="lblHeader1Resource1"></asp:Label>
            </h1>
            <asp:GridView ID="gridBestSelling" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                GridLines="None" BackColor="#FDFDF0" Width="100%" AlternatingRowStyle-BackColor="#EEEEF0"
                HeaderStyle-BackColor="#EEEEF0" BorderColor="#EEEEF0" BorderStyle="Solid" meta:resourcekey="gridBestSellingResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource1" ></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource1" ></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetFirstProducts"
                TypeName="BLL.Product">
                <SelectParameters>
                    <asp:Parameter DefaultValue="TotalRaiting" Name="sortExpression" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <p>
        </p>
        <div>
            <h1>
                <asp:Label ID="lblHeader2" runat="server" Text="Latest Arrivals" meta:resourcekey="lblHeader2Resource1"></asp:Label>
            </h1>
            <asp:GridView ID="gridLatestArrivals" runat="server" AutoGenerateColumns="False"
                DataSourceID="ObjectDataSource2" GridLines="None" AlternatingRowStyle-BackColor="#EEEEF0"
                HeaderStyle-BackColor="#EEEEF0" BorderColor="#EEEEF0" BorderStyle="Solid" Width="100%"
                meta:resourcekey="gridLatestArrivalsResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource2"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource7">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource2"></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource8">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource2"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource9">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource2"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource10">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource2"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetFirstProducts"
                TypeName="BLL.Product">
                <SelectParameters>
                    <asp:Parameter DefaultValue="AddedDate" Name="sortExpression" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <p>
        </p>
        <div>
            <h1>
                <asp:Label ID="lblHeader3" runat="server" Text="Products With Discount" meta:resourcekey="lblHeader3Resource1"></asp:Label>
            </h1>
            <asp:GridView ID="gridDIscount" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3"
                GridLines="None" AlternatingRowStyle-BackColor="#EEEEF0" HeaderStyle-BackColor="#EEEEF0"
                BorderColor="#EEEEF0" BorderStyle="Solid" Width="100%" meta:resourcekey="gridDIscountResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource11">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource3"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource12">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource3"></asp:HyperLink>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource13">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource3"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource14">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource3"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource15">
                        <ItemTemplate>
                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                                meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource16">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource3"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetFirstProducts"
                TypeName="BLL.Product">
                <SelectParameters>
                    <asp:Parameter DefaultValue="DiscountPercentage" Name="sortExpression" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
