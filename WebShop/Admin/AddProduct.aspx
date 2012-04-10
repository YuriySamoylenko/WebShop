<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="AddProduct.aspx.cs"
    Inherits="Admin_AddProduct" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/Controls/MyCheckBoxList.ascx" TagName="MyCheckBoxList" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mpart">
        <h2>
            <asp:Label ID="lblHeader" runat="server" Text="Add Products" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </h2>
        <h3>
        </h3>
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:LinkButton ID="lkbAddNew" runat="server" Text="Add New Product" OnClick="lkbAddNew_Click"
                    meta:resourcekey="lkbAddNewResource1"></asp:LinkButton>
                <br />
                <br />
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectDepartment" runat="server" Text="Select Department:" Font-Bold="True"
                                meta:resourcekey="lblSelectDepartmentResource1"></asp:Label>
                            <asp:DropDownList ID="ddlDepartments" runat="server" AutoPostBack="True" DataTextField="Title"
                                DataValueField="ID" AppendDataBoundItems="True" DataSourceID="SourceDepartmnets"
                                meta:resourcekey="ddlDepartmentsResource1">
                                <asp:ListItem Value="0" Text="All Departments" meta:resourcekey="ListItemResource1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblSorting" runat="server" Text="Sort By:" Font-Bold="True" meta:resourcekey="lblSortingResource1"></asp:Label>
                            <asp:DropDownList ID="ddlSorting" runat="server" AutoPostBack="True" meta:resourcekey="ddlSortingResource1">
                                <asp:ListItem Text="By Title" Value="Title" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="By Total Raiting" Value="TotalRaiting" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                <asp:ListItem Text="By Added Date" Value="AddedDate" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                <asp:ListItem Text="By Department" Value="DepartmentTitle" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                <asp:ListItem Text="By Price" Value="UnitPrice" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                <asp:ListItem Text="By Discount" Value="DiscountPercentage" meta:resourcekey="ListItemResource7"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lblOrder" runat="server" Text="Order By:" Font-Bold="True" meta:resourcekey="lblOrderResource1"></asp:Label>
                            <asp:DropDownList ID="ddlOrder" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSorting_SelectedIndexChanged"
                                meta:resourcekey="ddlOrderResource1">
                                <asp:ListItem Text="Ascending" Value=" ASC" Selected="True" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                <asp:ListItem Text="Descending" Value=" DESC" meta:resourcekey="ListItemResource9"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <asp:ObjectDataSource ID="SourceDepartmnets" runat="server" SelectMethod="GetDepartments"
                    TypeName="BLL.Department"></asp:ObjectDataSource>
                <asp:GridView ID="GridProducts" runat="server" AutoGenerateColumns="False" DataSourceID="SourceProducts"
                    GridLines="None" DataKeyNames="ID" OnSelectedIndexChanged="GridProducts_SelectedIndexChanged"
                    BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0" BorderStyle="Solid" OnSelectedIndexChanging="GridProducts_SelectedIndexChanging"
                    AllowPaging="True" meta:resourcekey="GridProductsResource1">
                    <AlternatingRowStyle BackColor="#EEEEF0" />
                    <Columns>
                        <asp:ImageField DataImageUrlField="SmallImageUrl" meta:resourcekey="ImageFieldResource1">
                        </asp:ImageField>
                        <asp:HyperLinkField DataTextField="Title" HeaderText="Product" SortExpression="Title"
                            meta:resourcekey="HyperLinkFieldResource1">
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="UnitsInStock" HeaderText="Units In Stock" SortExpression="UnitsInStock"
                            meta:resourcekey="BoundFieldResource1">
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="UnitPrice" DataFormatString="{0:0.00}$" HeaderText="Price"
                            SortExpression="UnitPrice" meta:resourcekey="BoundFieldResource2">
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" meta:resourcekey="CommandFieldResource1" />
                    </Columns>
                    <HeaderStyle BackColor="#EEEEF0" />
                </asp:GridView>
                <asp:ObjectDataSource ID="SourceProducts" runat="server" DeleteMethod="DeleteProduct"
                    SelectMethod="GetProductsByDepartment" TypeName="BLL.Product">
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartments" DefaultValue="0" Name="departmentID"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlSorting" DefaultValue="Title" Name="sortExpression"
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlOrder" DefaultValue="" Name="order" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <asp:DetailsView ID="DetailsCurrentProduct" runat="server" Height="50px" Width="100%"
                    AutoGenerateRows="False" DataSourceID="SourceCurrentProduct" GridLines="None"
                    HeaderText="Product Details" BackColor="#FDFDF0" DefaultMode="Insert" AutoGenerateEditButton="True"
                    OnItemInserted="DetailsCurrentProduct_ItemInserted" OnItemUpdated="DetailsCurrentProduct_ItemUpdated"
                    DataKeyNames="ID" meta:resourcekey="DetailsCurrentProductResource1" 
                    AutoGenerateInsertButton="True" 
                    oniteminserting="DetailsCurrentProduct_ItemInserting">
                    <Fields>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                            InsertVisible="False" meta:resourcekey="BoundFieldResource3" />
                        <asp:BoundField DataField="AddedDate" HeaderText="AddedDate" ReadOnly="True" SortExpression="AddedDate"
                            InsertVisible="False" meta:resourcekey="BoundFieldResource4" />
                        <asp:BoundField DataField="AddedBy" HeaderText="AddedBy" ReadOnly="True" SortExpression="AddedBy"
                            InsertVisible="False" meta:resourcekey="BoundFieldResource5" />
                        <asp:TemplateField HeaderText="Departments" meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <uc1:MyCheckBoxList ID="chbxDepartments" runat="server" OnDataBinding="chbxDepartmentsDataBinding" departments='<%# Bind("DepartmentID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Title" meta:resourcekey="TemplateFieldResource2">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxTitle" runat="server" Text='<%# Bind("Title") %>' Width="95%"
                                    meta:resourcekey="tbxTitleResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource3">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxDescroption" runat="server" Text='<%# Bind("Description") %>'
                                    Width="95%" TextMode="MultiLine" Rows="4" meta:resourcekey="tbxDescroptionResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="SKU" DataField="SKU" meta:resourcekey="BoundFieldResource6" />
                        <asp:TemplateField HeaderText="Unit Price $" meta:resourcekey="TemplateFieldResource4">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxPrice" runat="server" Text='<%# Bind("UnitPrice", "{0:N2}") %>'
                                    Width="95%" meta:resourcekey="tbxPriceResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount %" meta:resourcekey="TemplateFieldResource5">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxDiscount" runat="server" Text='<%# Bind("DiscountPercentage") %>'
                                    Width="95%" meta:resourcekey="tbxDiscountResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Units In Stock" meta:resourcekey="TemplateFieldResource6">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxInStock" runat="server" Text='<%# Bind("UnitsInStock") %>' Width="95%"
                                    meta:resourcekey="tbxInStockResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Small Image Url" meta:resourcekey="TemplateFieldResource7">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxSmallImageUrl" runat="server" Text='<%# Bind("SmallImageUrl") %>'
                                    Width="95%" meta:resourcekey="tbxSmallImageUrlResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Full Image Url" meta:resourcekey="TemplateFieldResource8">
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxFullImageUrl" runat="server" Text='<%# Bind("FullImageUrl") %>'
                                    Width="95%" meta:resourcekey="tbxFullImageUrlResource1"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <HeaderStyle BackColor="#3F4040" ForeColor="White" />
                </asp:DetailsView>
                <asp:ObjectDataSource ID="SourceCurrentProduct" runat="server" InsertMethod="InsertProduct"
                    SelectMethod="GetProductByID" TypeName="BLL.Product" 
                    UpdateMethod="UpdateProduct">
                    <InsertParameters>
                        <asp:Parameter Name="departmentID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="description" Type="String" />
                        <asp:Parameter Name="sku" Type="String" />
                        <asp:Parameter Name="unitPrice" Type="Decimal" />
                        <asp:Parameter Name="discountPercentage" Type="Int32" />
                        <asp:Parameter Name="unitsInStock" Type="Int32" />
                        <asp:Parameter Name="smallImageUrl" Type="String" />
                        <asp:Parameter Name="fullImageUrl" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridProducts" Name="productID" PropertyName="SelectedValue"
                            Type="Int32" DefaultValue="0" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="DetailsCurrentProduct" Name="id" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:Parameter Name="departmentID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="description" Type="String" />
                        <asp:Parameter Name="sku" Type="String" />
                        <asp:Parameter Name="unitPrice" Type="Decimal" />
                        <asp:Parameter Name="discountPercentage" Type="Int32" />
                        <asp:Parameter Name="unitsInStock" Type="Int32" />
                        <asp:Parameter Name="smallImageUrl" Type="String" />
                        <asp:Parameter Name="fullImageUrl" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:Button ID="btnBack" runat="server" Text="Back" CommandName="PrevView" meta:resourcekey="btnBackResource1" />
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
