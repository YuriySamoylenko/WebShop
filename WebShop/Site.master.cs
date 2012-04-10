using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.DynamicData;
using System.Web.Management;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Profile;
using System.Web.Security;
using System.Threading;
using System.Globalization;
using System.Security.Permissions;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)
    {

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            hlkOrders.Visible = true;
            hlkOrders.NavigateUrl = string.Format("~/ShowOrders.aspx?userName={0}", Profile.UserName);
        }

        if (Profile.ShoppingCart.Items.Count > 0)
        {
            lblCartContent.Visible = false;
            Label2.Text = Profile.ShoppingCart.ItemsCount.ToString();
            Label4.Text = string.Format("{0:C}", Profile.ShoppingCart.Total);
            Label1.Visible = true;
            Label2.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;
        }
    }
    protected void hlkEng_Click(object sender, EventArgs e)
    {
        Session.Add("Lang", "en");
        Response.Redirect(Request.Url.ToString());
    }
    protected void hlkRus_Click(object sender, EventArgs e)
    {
        Session.Add("Lang", "ru");
        Response.Redirect(Request.Url.ToString());
    }
}

