using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using BLL;

public partial class ShowProduct : System.Web.UI.Page
{
    int productID = 0;

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
        if (string.IsNullOrEmpty(this.Request.QueryString["id"]))
            throw new ApplicationException("Missing parameter on the querystring.");
        else
            productID = int.Parse(this.Request.QueryString["id"]);

        Product product = Product.GetProductByID(productID);
        if (product == null)
            throw new ApplicationException("No product was found for the specified ID.");



        HyperLink link = (HyperLink)FormView1.FindControl("hlkImage");
        if (product.FullImageUrl.Length < 0)
            link.Enabled = false; 
    }
    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        Product product = Product.GetProductByID(productID);
        Profile.ShoppingCart.InsertItem(product.ID, product.Title, product.FinalUnitPrice, 1);
        if (Profile.ShoppingCart.Total > 5000)
        {
            Profile.ShoppingCart.DeleteItem(product.ID);
            lblOverLimit.Text = GetLocalResourceObject("lblOverLimitResource1.Text").ToString() + string.Format("Total order price should not be over {0:C}" + 5000M);
        }
        else
        {
            Response.Redirect("ShoppingCartPage.aspx");
        }
    }
}