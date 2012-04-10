<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ViewReports.aspx.cs"
    Inherits="Admin_ViewReports" meta:resourcekey="PageResource1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lblHeader" runat="server" Text="Reports" meta:resourcekey="lblHeaderResource1"></asp:Label>
    </h2>
    <h3>
    </h3>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <asp:LinkButton ID="lkbtnBestSellers" runat="server" Text="Best Selling Products"
                OnClick="lkbtnBestSellers_Click" meta:resourcekey="lkbtnBestSellersResource1"></asp:LinkButton>
            <br />
            <asp:LinkButton ID="lkbtnShopProfit" runat="server" Text="Shop Profit" OnClick="lkbtnShopProfit_Click"
                meta:resourcekey="lkbtnShopProfitResource1"></asp:LinkButton>
            <br />
            <asp:LinkButton ID="lnkbtnSales" runat="server" Text="Sales" OnClick="lnkbtnSales_Click"
                meta:resourcekey="lnkbtnSalesResource1"></asp:LinkButton>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <h3>
                <asp:Label ID="lblBestSells" runat="server" Text="Best Selling Products:" meta:resourcekey="lblBestSellsResource1"></asp:Label>
            </h3>
            <asp:GridView ID="gridProducts" runat="server" AutoGenerateColumns="False" DataSourceID="odsProducts"
                Width="100%" GridLines="None" BackColor="#FDFDF0" BorderColor="#EEEEF0" BorderStyle="Solid"
                meta:resourcekey="gridProductsResource1">
                <AlternatingRowStyle BackColor="#EEEEF0" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                        meta:resourcekey="BoundFieldResource1">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="hlkTitle" runat="server" Text='<%# Eval("Title") %>' Font-Bold="True"
                                meta:resourcekey="hlkTitleResource1"></asp:Label><br />
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescriptionResource1"></asp:Label></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UnitPrice" DataFormatString="{0:0.00}$" HeaderText="UnitPrice"
                        ReadOnly="True" SortExpression="UnitPrice" meta:resourcekey="BoundFieldResource2">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DepartmentID" HeaderText="Depart" ReadOnly="True" SortExpression="DepartmentTitle"
                        meta:resourcekey="BoundFieldResource3">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AddedDate" DataFormatString="{0:d}" HeaderText="Date"
                        ReadOnly="True" SortExpression="AddedDate" meta:resourcekey="BoundFieldResource4">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DiscountPercentage" HeaderText="Discount" ReadOnly="True"
                        SortExpression="DiscountPercentage" meta:resourcekey="BoundFieldResource5">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="UnitsInStock" HeaderText="InStock" ReadOnly="True" SortExpression="UnitsInStock"
                        meta:resourcekey="BoundFieldResource6" />
                    <asp:BoundField DataField="TotalRaiting" HeaderText="Rating" ReadOnly="True" SortExpression="TotalRaiting"
                        meta:resourcekey="BoundFieldResource7">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0" />
            </asp:GridView>
            <asp:ObjectDataSource ID="odsProducts" runat="server" SelectMethod="GetProducts"
                TypeName="BLL.Product">
                <SelectParameters>
                    <asp:Parameter DefaultValue="TotalRaiting" Name="sortExpression" Type="String" />
                    <asp:Parameter DefaultValue=" DESC" Name="order" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
        </asp:View>
        <asp:View ID="View3" runat="server">
            <table width="100%">
                <tr>
                    <td>
                        <asp:Label ID="lblViewReports" runat="server" Text="View Reports:" Font-Bold="True"
                            meta:resourcekey="lblViewReportsResource1"></asp:Label>
                    </td>
                </tr>
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
                <tr>
                    <td>
                        <asp:LinkButton ID="lnkbtnLoad" runat="server" Text="Load" OnClick="lnkbtnLoad_Click"
                            meta:resourcekey="lnkbtnLoadResource1"></asp:LinkButton>
                    </td>
                </tr>
            </table>
            <h3>
                <asp:Label ID="lblShopProfit" runat="server" Text="Shop Profit" Visible="False" meta:resourcekey="lblShopProfitResource1"></asp:Label></h3>
            <asp:Label ID="lblFromTo" runat="server" meta:resourcekey="lblFromToResource1"></asp:Label>
            <asp:GridView ID="gridProfit" runat="server" GridLines="None" Width="100%" BackColor="#FDFDF0"
                BorderColor="#EEEEF0" BorderStyle="Solid" AutoGenerateColumns="False" DataKeyNames="Money"
                meta:resourcekey="gridProfitResource1">
                <AlternatingRowStyle BackColor="#EEEEF0" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" meta:resourcekey="BoundFieldResource8">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" meta:resourcekey="BoundFieldResource9">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OrderID" HeaderText="OrderID" meta:resourcekey="BoundFieldResource10">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Money" DataFormatString="{0:0.00}$" HeaderText="Money" meta:resourcekey="BoundFieldResource11">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0" />
            </asp:GridView>
            <asp:Label ID="lblTotalProfit" runat="server" Text="Total Profit:" Font-Bold="True"
                Visible="False" meta:resourcekey="lblTotalProfitResource1"></asp:Label>
            <asp:Label ID="lblTotalProfitValue" runat="server" meta:resourcekey="lblTotalProfitValueResource1"></asp:Label>
            <p>
            </p>
            <asp:Button ID="btnBack2" runat="server" Text="Back" OnClick="btnBack_Click" meta:resourcekey="btnBack2Resource1" />
        </asp:View>
        <asp:View ID="View4" runat="server">
            <table width="100%">
                <tr>
                    <td>
                        <asp:Label ID="lblViewSales" runat="server" Text="View Sales:" Font-Bold="True" meta:resourcekey="lblViewSalesResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblFrom" runat="server" Text="From Date:" Font-Bold="True" meta:resourcekey="lblFromResource1"></asp:Label>
                        <asp:Calendar ID="cdrFrom" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" Width="200px" meta:resourcekey="cdrFromResource1">
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
                        <asp:Label ID="lblTo" runat="server" Text="To Date:" Font-Bold="True" meta:resourcekey="lblToResource1"></asp:Label>
                        <asp:Calendar ID="cdrTo" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4"
                            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black"
                            Height="180px" Width="200px" meta:resourcekey="cdrToResource1">
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
                <tr>
                    <td>
                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Load" OnClick="LinkButton1_Click"
                            meta:resourcekey="LinkButton1Resource1"></asp:LinkButton>
                    </td>
                </tr>
            </table>
            <h3>
                <asp:Label ID="lblSales" runat="server" Text="Sales" Visible="False" meta:resourcekey="lblSalesResource1"></asp:Label></h3>
            <asp:Label ID="lblFromTo2" runat="server" meta:resourcekey="lblFromTo2Resource1"></asp:Label>
            <asp:GridView ID="gridSales" runat="server" AutoGenerateColumns="False" GridLines="None"
                Width="100%" BackColor="#FDFDF0" BorderColor="#EEEEF0" BorderStyle="Solid" meta:resourcekey="gridSalesResource1">
                <AlternatingRowStyle BackColor="#EEEEF0" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" meta:resourcekey="BoundFieldResource12"
                        SortExpression="ID">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" meta:resourcekey="BoundFieldResource13"
                        SortExpression="Date">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OrderID" HeaderText="OrderID" meta:resourcekey="BoundFieldResource14"
                        SortExpression="OrderID">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MethodOfPayment" HeaderText="MethodOfPayment" meta:resourcekey="BoundFieldResource15"
                        SortExpression="MethodOfPayment">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" meta:resourcekey="BoundFieldResource16"
                        SortExpression="ProductID">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProdTitle" HeaderText="ProdTitle" meta:resourcekey="BoundFieldResource17"
                        SortExpression="ProdTitle">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Units" HeaderText="Units" meta:resourcekey="BoundFieldResource18"
                        SortExpression="Units">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Price" DataFormatString="{0:0.00}$" HeaderText="Price" meta:resourcekey="BoundFieldResource19"
                        SortExpression="Price">
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="#EEEEF0" />
            </asp:GridView>
            <asp:Button ID="btnBack3" runat="server" Text="Back" OnClick="btnBack_Click" meta:resourcekey="btnBack3Resource1" />
        </asp:View>
    </asp:MultiView>
</asp:Content>
