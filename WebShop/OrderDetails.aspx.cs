using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Web.Security;
using System.Threading;
using System.Globalization;
using BLL;
using DAL;

public partial class OrderDetails : System.Web.UI.Page
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
        if (!IsPostBack) lblNewLevel.Text = "";
        if (!string.IsNullOrEmpty(Request.QueryString["orderID"]))
        {
            OrdersData order = Order.GetOrderByID(Convert.ToInt32(Request.QueryString["orderID"]));
            if (order.StatusID == (int)StatusCode.Canceled || order.StatusID == (int)StatusCode.Delivered)
            {
                btnCancelOrder.Visible = false;
                lnkbtnAddProduct.Visible = false;
            }
            if (order.StatusID == (int)StatusCode.Unexecuted || order.Paid == true)
                lnkbtnAddProduct.Visible = false;

            if (order.StatusID == (int)StatusCode.Canceled || order.StatusID == (int)StatusCode.Delivered ||
                order.StatusID == (int)StatusCode.Unexecuted || order.MethodOfPayment == "CreditCard" || order.Paid == true)
            {
                btnPayOrder.Visible = false;
            }
        }
        if (Profile.Money > 0)
        {
            lblScoreValue.Text = string.Format("{0:0.00}$", Profile.Money);
        }
        else
        {
            lblScoreValue.Text = string.Format("{0:0.00}$", 0.0M);
        }
    }

    protected void btnCancelOrder_Click(object sender, EventArgs e)
    {
        Order.UpdateOrder(Convert.ToInt32(DetailsView1.DataKey.Value), (int)StatusCode.Canceled, DateTime.MinValue, "", "");
        DetailsView1.DataBind();
        Page_Load(null, null);
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Order.UpdateOrder(Convert.ToInt32(DetailsView1.DataKey.Value), (int)StatusCode.Unexecuted, DateTime.MinValue, "", "");
        Profile.ShoppingCart.Clear();
        foreach (OrderItemsData item in OrderItem.GetOrderItemsByOrderID(Convert.ToInt32(DetailsView1.DataKey.Value)))
        {
            Profile.ShoppingCart.InsertItem(item.ProductID, item.Title, item.UnitPrice, item.Quantity);
        }
        Profile.ShoppingCart.OrderID = Convert.ToInt32(DetailsView1.DataKey.Value);

        Response.Redirect("~/ShoppingCartPage.aspx?orderID=" + Request.QueryString["orderID"]);
    }
    protected void btnPayOrder_Click(object sender, EventArgs e)
    {
        OrdersData order = (new Sql_Provider()).GetOrdersByID(Convert.ToInt32(DetailsView1.DataKey.Value));

        //
        if (order.MethodOfPayment == "Internal")
        {
            if (Order.UpdateOrdersPaid(order.ID, true))
                Profile.Money -= order.SubTotal;
        }

        // If order price greater then 3000 add user to "ElectedUser" role
        if (order.SubTotal > 3000)
        {
            if (!User.IsInRole("ElectedUser"))
            {
                Roles.AddUserToRole(Servise.GetCurrentUserName(), "ElectedUser");
                lblNewLevel.Text = GetLocalResourceObject("lblNewLevelResource1.Text").ToString(); 
            }
        }

        List<OrderItemsData> items = OrderItem.GetOrderItemsByOrderID(order.ID);

        foreach (OrderItemsData item in items)
        {
            Product.UpdateProductRating(item.ProductID, item.Quantity);
        }

        

        DetailsView1.DataBind();
        Page_Load(null, null);
    }
}