<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Search.aspx.cs"
    Inherits="Search" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Search Product" meta:resourcekey="lblHeaderResource1"></asp:Label></h2>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View0" runat="server">
            <asp:LinkButton ID="lkbtnByName" runat="server" Text="Search By Name" OnClick="lkbtnByName_Click"
                meta:resourcekey="lkbtnByNameResource1"></asp:LinkButton>
            <br />
            <asp:LinkButton ID="lkbtnByDate" runat="server" Text="Search By Added Date" OnClick="lkbtnByDate_Click"
                meta:resourcekey="lkbtnByDateResource1"></asp:LinkButton>
            <br />
            <asp:LinkButton ID="lkbtnByDepartment" runat="server" Text="Search By Department"
                OnClick="lkbtnByDepartment_Click" meta:resourcekey="lkbtnByDepartmentResource1"></asp:LinkButton>
        </asp:View>
        <asp:View ID="View1" runat="server">
            <h3>
                <asp:Label ID="lblByName" runat="server" Text="By Name:" meta:resourcekey="lblByNameResource1"></asp:Label>
            </h3>
            <asp:TextBox ID="tbxSearchName" runat="server" meta:resourcekey="tbxSearchNameResource1"></asp:TextBox>
            <asp:LinkButton ID="btnSearchName" runat="server" Text="Search" OnClick="btnSearchName_Click"
                meta:resourcekey="btnSearchNameResource1" />
            <asp:GridView ID="gridProducts" runat="server" AutoGenerateColumns="False" GridLines="None"
                DataKeyNames="ID" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0" BorderStyle="Solid"
                AllowPaging="True" meta:resourcekey="gridProductsResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource1"></asp:HyperLink>
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                                meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:LinkButton ID="lkbtnBack" runat="server" Text="Back" OnClick="lkbtnBack3_Click"
                meta:resourcekey="lkbtnBackResource1"></asp:LinkButton>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <h3>
                <asp:Label ID="lblByDate" runat="server" Text="By Added Date:" meta:resourcekey="lblByDateResource1"></asp:Label>
            </h3>
            <table width="100%">
                <tr>
                    <td>
                        <asp:Label ID="lblFromDate" runat="server" Text="From Date:" Font-Bold="True" meta:resourcekey="lblFromDateResource1"></asp:Label>
                        <asp:Calendar ID="clrFromDate" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" Width="200px" meta:resourcekey="clrFromDateResource1">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                        </asp:Calendar>
                    </td>
                    <td>
                        <asp:Label ID="lblToDate" runat="server" Text="To Date:" Font-Bold="True" meta:resourcekey="lblToDateResource1"></asp:Label>
                        <asp:Calendar ID="clrToDate" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" Width="200px" meta:resourcekey="clrToDateResource1">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                        </asp:Calendar>
                    </td>
                </tr>
            </table>
            <asp:LinkButton ID="btnSearchDate" runat="server" Text="Search" OnClick="btnSearchDate_Click"
                meta:resourcekey="btnSearchDateResource1" />
            <asp:GridView ID="gridProductsDate" runat="server" AutoGenerateColumns="False" GridLines="None"
                DataKeyNames="ID" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0" BorderStyle="Solid"
                AllowPaging="True" meta:resourcekey="gridProductsResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource1"></asp:HyperLink>
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                                meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:LinkButton ID="lkbtnBack2" runat="server" Text="Back" OnClick="lkbtnBack3_Click"
                meta:resourcekey="lkbtnBack2Resource1"></asp:LinkButton>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <h3>
                <asp:Label ID="lblByDepartment" runat="server" Text="By Department:" meta:resourcekey="lblByDepartmentResource1"></asp:Label>
            </h3>
            <asp:DropDownList ID="ddlDepartments" runat="server" DataSourceID="ObjectDataSource1"
                DataTextField="Title" DataValueField="ID" AppendDataBoundItems="True" meta:resourcekey="ddlDepartmentsResource1">
                <asp:ListItem Value="0" Text="All Departments" meta:resourcekey="ListItemResource1"></asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="btnSearchDepartment" runat="server" Text="Search" OnClick="btnSearchDepartment_Click"
                meta:resourcekey="btnSearchDepartmentResource1" />
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDepartments"
                TypeName="BLL.Department"></asp:ObjectDataSource>
            <asp:GridView ID="gridProductsDepartment" runat="server" AutoGenerateColumns="False"
                GridLines="None" DataKeyNames="ID" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0"
                BorderStyle="Solid" AllowPaging="True" meta:resourcekey="gridProductsResource1">
                <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkImage" runat="server" ImageUrl='<%# Eval("SmallImageUrl") %>'
                                NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>' meta:resourcekey="hlkImageResource1"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' NavigateUrl='<%# "ShowProduct.aspx?id=" + Eval("ID") %>'
                                meta:resourcekey="hlkTitleResource1"></asp:HyperLink>
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Added Date" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:Label ID="lblAddedDate" runat="server" Text='<%# Eval("AddedDate", "{0:d}") %>'
                                meta:resourcekey="lblAddedDateResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}$") %>'
                                meta:resourcekey="lblUnitPriceResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("DiscountPercentage") %>'
                                meta:resourcekey="lblDiscountResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalRaiting" runat="server" Text='<%# Eval("TotalRaiting") %>'
                                meta:resourcekey="lblTotalRaitingResource1"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0"></HeaderStyle>
            </asp:GridView>
            <asp:LinkButton ID="lkbtnBack3" runat="server" Text="Back" OnClick="lkbtnBack3_Click"
                meta:resourcekey="lkbtnBack3Resource1"></asp:LinkButton>
        </asp:View>
    </asp:MultiView>
    <asp:Label ID="lblNotFound" runat="server" Text="Not Found" Visible="False" meta:resourcekey="lblNotFoundResource1"></asp:Label>
</asp:Content>
