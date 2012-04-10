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

public partial class Admin_ViewReports : System.Web.UI.Page
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
        if (!IsPostBack)
            clrFromDate.SelectedDate = clrToDate.SelectedDate = cdrFrom.SelectedDate = cdrTo.SelectedDate = DateTime.Now;
    }

    protected void lkbtnBestSellers_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }

    protected void lkbtnShopProfit_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
    }
    protected void lnkbtnSales_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 3;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void lnkbtnLoad_Click(object sender, EventArgs e)
    {
        List<ShopProfitData> source = ShopProfit.GetProfit("", clrFromDate.SelectedDate, clrToDate.SelectedDate);
        if (source.Count > 0)
        {
            gridProfit.DataSource = source;
            gridProfit.DataBind();
            lblTotalProfit.Visible = true;
            lblFromTo.Text = GetLocalResourceObject("lblFromDateResource1.Text").ToString() + string.Format(" {0} ", clrFromDate.SelectedDate.ToShortDateString()) + "-" +
                GetLocalResourceObject("lblToDateResource1.Text").ToString() + string.Format(" {1} ", clrToDate.SelectedDate.ToShortDateString());
            decimal total = 0.0M;
            foreach (ShopProfitData example in source)
            {
                total += example.Money;
            }
            lblTotalProfitValue.Text = string.Format("{0:0.00}$", total);
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        List<Sales> source = ShopProfit.GetSales(cdrFrom.SelectedDate, cdrTo.SelectedDate);
        if (source.Count > 0)
        {
            gridSales.DataSource = source;
            gridSales.DataBind();
            lblSales.Visible = true;
            lblFromTo2.Text = GetLocalResourceObject("lblFromDateResource1.Text").ToString() + string.Format(" {0} ", cdrFrom.SelectedDate.ToShortDateString()) + "-" +
                GetLocalResourceObject("lblToDateResource1.Text").ToString() + string.Format(" {1} ", cdrTo.SelectedDate.ToShortDateString());
        }
    }
}