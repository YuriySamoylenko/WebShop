using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;

public partial class Admin_AddProduct : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        if (Session["Lang"] != null)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["Lang"].ToString());
        }
        base.InitializeCulture();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        InitializeCulture();
    }
    protected void GridProducts_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void lkbAddNew_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        if (DetailsCurrentProduct.CurrentMode != DetailsViewMode.Insert)
            DetailsCurrentProduct.ChangeMode(DetailsViewMode.Insert);
    }
    protected void GridProducts_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        if (DetailsCurrentProduct.CurrentMode != DetailsViewMode.Edit)
            DetailsCurrentProduct.ChangeMode(DetailsViewMode.Edit);
        MultiView1.ActiveViewIndex = 1;
    }
    protected void DetailsCurrentProduct_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        GridProducts.DataBind();
    }
    protected void DetailsCurrentProduct_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        GridProducts.DataBind();
    }
    protected void ddlSorting_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridProducts.DataBind();
    }
    protected void chbxDepartmentsDataBinding(object sender, EventArgs e)
    {
        Controls_MyCheckBoxList myChbxList = (Controls_MyCheckBoxList)DetailsCurrentProduct.FindControl("chbxDepartments");
        myChbxList.ProductID = Convert.ToInt32(DetailsCurrentProduct.DataKey.Value);
    }
    protected void DetailsCurrentProduct_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        Controls_MyCheckBoxList myChbxList = (Controls_MyCheckBoxList)DetailsCurrentProduct.FindControl("chbxDepartments");
    }
}