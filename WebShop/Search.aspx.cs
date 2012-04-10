using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using DAL;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblNotFound.Visible = false;
        if (!IsPostBack)
        {
            clrFromDate.SelectedDate = clrToDate.SelectedDate = DateTime.Now;
        }
    }
    protected void lkbtnByName_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }
    protected void lkbtnByDate_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
    }
    protected void lkbtnByDepartment_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 3;
    }
    protected void btnSearchName_Click(object sender, EventArgs e)
    {
        lblNotFound.Visible = false;
        List<Product> source = Product.GetProductByName(tbxSearchName.Text);
        if (!(source.Count > 0))
        {
            lblNotFound.Visible = true;
            return;
        }
        gridProducts.DataSource = source;
        gridProducts.DataBind();
    }
    protected void btnSearchDate_Click(object sender, EventArgs e)
    {
        lblNotFound.Visible = false;
        List<Product> source = Product.GetProductsByDate(clrFromDate.SelectedDate, clrToDate.SelectedDate);
        if (!(source.Count > 0))
        {
            lblNotFound.Visible = true;
            return;
        }
        gridProductsDate.DataSource = source;
        gridProductsDate.DataBind();
    }
    protected void btnSearchDepartment_Click(object sender, EventArgs e)
    {
        lblNotFound.Visible = false;
        List<Product> source = Product.GetProductsByDepartment(Convert.ToInt32(ddlDepartments.SelectedValue), "", "");
        if (!(source.Count > 0))
        {
            lblNotFound.Visible = true;
            return;
        }
        gridProductsDepartment.DataSource = source;
        gridProductsDepartment.DataBind();
    }
    protected void lkbtnBack3_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
}