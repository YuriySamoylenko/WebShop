using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using BLL;
using DAL;

public partial class Admin_EditOrders : System.Web.UI.Page
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
    protected void btnCustomerLoad_Click(object sender, EventArgs e)
    {
        List<OrdersData> orders = null;
        orders = Order.GetOrdersByCustomer(tbxCustomer.Text);
        GridView1.DataSource = orders;
        GridView1.DataBind();
    }
    protected void btnIDLoad_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(tbxID.Text))
        {
            Response.Redirect("EditOrder.aspx?orderID=" + Convert.ToInt32(tbxID.Text));
        }
    }

}