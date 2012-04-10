<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="EditDepartments.aspx.cs"
    Inherits="Admin_EditDepartments" Title="Web Shop : Edit Departments" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mpart">
        <h2>
            <asp:Label ID="lblHeader" runat="server" Text="Edit Departments" meta:resourcekey="lblHeaderResource1"></asp:Label>
        </h2>
        <h3>
        </h3>
        <asp:GridView ID="GridDepaertments" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="odsDepartments" GridLines="None" DataKeyNames="ID" OnSelectedIndexChanged="GridDepaertments_SelectedIndexChanged"
            AlternatingRowStyle-BackColor="ButtonFace" BackColor="#FDFDF0" Width="100%" BorderColor="#EEEEF0"
            BorderStyle="Solid" ShowHeader="False" meta:resourcekey="GridDepaertmentsResource1">
            <AlternatingRowStyle BackColor="#EEEEF0"></AlternatingRowStyle>
            <Columns>
                <asp:ImageField DataImageUrlField="ImageUrl" meta:resourcekey="ImageFieldResource1">
                </asp:ImageField>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <b>
                            <asp:Label runat="server" ID="lblTitle" Text='<%# Eval("Title") %>' meta:resourcekey="lblTitleResource1"></asp:Label></b>
                        <br />
                        <asp:Label runat="server" ID="lblDescrtopt" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescrtoptResource1"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowSelectButton="True" ShowDeleteButton="True" meta:resourcekey="CommandFieldResource1" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="odsDepartments" runat="server" DeleteMethod="DeleteDepartment"
            SelectMethod="GetDepartments" TypeName="BLL.Department">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
        </asp:ObjectDataSource>
        <p>
        </p>
        <asp:DetailsView ID="DetailsDepartment" runat="server" Height="50px" Width="100%"
            AutoGenerateRows="False" DataSourceID="odsDepartDetails" AutoGenerateEditButton="True"
            AutoGenerateInsertButton="True" DefaultMode="Insert" GridLines="None" OnItemInserted="DetailsDepartment_ItemInserted"
            BackColor="#FDFDF0" OnItemUpdated="DetailsDepartment_ItemUpdated" DataKeyNames="ID"
            HeaderStyle-BackColor="#3F4040" HeaderStyle-ForeColor="White" HeaderText="Department Details"
            meta:resourcekey="DetailsDepartmentResource1">
            <Fields>
                <asp:TemplateField HeaderText="ID" InsertVisible="false" meta:resourcekey="TemplateFieldResource2">
                    <ItemTemplate>
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' meta:resourcekey="lblIDResource1"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AddedDate" HeaderText="AddedDate" ReadOnly="True" SortExpression="AddedDate"
                    InsertVisible="false" meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="AddedBy" HeaderText="AddedBy" ReadOnly="True" SortExpression="AddedBy"
                    InsertVisible="false" meta:resourcekey="BoundFieldResource2" />
                <asp:TemplateField HeaderText="Title" meta:resourcekey="TemplateFieldResource3">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbxTitle" runat="server" Text='<%# Bind("Title") %>' Width="95%"
                            meta:resourcekey="tbxTitleResource1"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Importance" meta:resourcekey="TemplateFieldResource4">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbxImportance" runat="server" Text='<%# Bind("Importance") %>' Width="95%"
                            meta:resourcekey="tbxImportanceResource1"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource5">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbxDescription" runat="server" Text='<%# Bind("Description") %>'
                            Width="95%" TextMode="MultiLine" Rows="4" meta:resourcekey="tbxDescriptionResource1"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ImageUrl" meta:resourcekey="TemplateFieldResource6">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbxImmageUrl" runat="server" Text='<%# Bind("ImageUrl") %>' Width="95%"
                            meta:resourcekey="tbxImmageUrlResource1"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Fields>
            <HeaderStyle BackColor="#3F4040" ForeColor="White"></HeaderStyle>
        </asp:DetailsView>
        <asp:ObjectDataSource ID="odsDepartDetails" runat="server" InsertMethod="InsertDepartment"
            SelectMethod="GetDepartmentByID" TypeName="BLL.Department" 
            UpdateMethod="UpdateDepartment">
            <InsertParameters>
                <asp:Parameter Name="title" Type="String" />
                <asp:Parameter Name="importance" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="imageUrl" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridDepaertments" Name="departmentID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="id" Type="Int32" />
                <asp:Parameter Name="title" Type="String" />
                <asp:Parameter Name="importance" Type="Int32" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="imageUrl" Type="String" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
