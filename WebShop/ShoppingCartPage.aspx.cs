using System;
using System.Collections;
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
using BLL;
using DAL;

public partial class ShoppingCartPage : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        if (Session["Lang"] != null)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["Lang"].ToString());
        }
        base.InitializeCulture();
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        gridCart.DataSource = Profile.ShoppingCart.Items;
        
        gridCart.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        InitializeCulture();
        if (Profile.ShoppingCart.OrderID > 0)
        {
            lblEditingOrder.Visible = true;
            if (!Page.IsPostBack)
                lblEditingOrder.Text += Profile.ShoppingCart.OrderID;
        }
        if (Profile.ShoppingCart.Items.Count > 0)
        {
            lblEmpty.Visible = false;
            lblShoppingCart.Visible = true;
            Wizard1.Visible = true;
        }

        lblPrice.Text = GetLocalResourceObject("lblPriceResource1.Text").ToString() + string.Format("{0:0.00}$", Profile.ShoppingCart.Total);
        lblDiscount.Text = GetLocalResourceObject("lblDiscountResource1.Text").ToString() + string.Format("{0}%", Profile.ShoppingCart.AuthorizedDiscount);
        lblTotal.Text = GetLocalResourceObject("lblTotalResource1.Text").ToString() + string.Format("Total Price: {0:0.00}$", Profile.ShoppingCart.TotalWithDiscount);
    }

    protected void BtnUpdate_OnClick(object sender, EventArgs e)
    {
        UpdateTotal();
    }

    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (Wizard1.ActiveStepIndex == 0)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
                Response.Redirect("~/Account/Login.aspx" + Profile.UserName);

            MembershipUserCollection users;
            users = Membership.GetAllUsers();
            MembershipUser currentUser = users[Profile.UserName];

            foreach (GridViewRow row in gridCart.Rows)
            {
                int id = Convert.ToInt32(gridCart.DataKeys[row.RowIndex][0]);
                int quantity = Convert.ToInt32((row.FindControl("tbxQuantity") as TextBox).Text);
                Profile.ShoppingCart.UpdateItemQuantity(id, quantity);
            }


            if (tbxFirstName.Text.Trim().Length <= 0)
                tbxFirstName.Text = Profile.FirstName;
            if (tbxLastName.Text.Trim().Length <= 0)
                tbxLastName.Text = Profile.LastName;

            if (Profile.ShoppingCart.OrderID > 0)
            {
                OrdersData order = new Sql_Provider().GetOrdersByID(Profile.ShoppingCart.OrderID);

                if (tbxTelNum.Text.Trim().Length <= 0)
                    tbxTelNum.Text = order.CustomerPhone;
                if (tbxEmail.Text.Trim().Length <= 0)
                    tbxEmail.Text = order.CustomerEmail;
                if (tbxAdress.Text.Trim().Length <= 0)
                    tbxAdress.Text = order.DeliveryAddress;
            }
            else
            {
                if (tbxTelNum.Text.Trim().Length <= 0)
                    tbxTelNum.Text = Profile.TelephoneNumber;
                if (tbxEmail.Text.Trim().Length <= 0)
                    tbxEmail.Text = currentUser.Email;
                if (tbxAdress.Text.Trim().Length <= 0)
                    tbxAdress.Text = Profile.Adress;
            }

        }
        gridCart.DataBind();

        if (Wizard1.ActiveStepIndex == 1)
        {
            lblFirstName2.Text = tbxFirstName.Text;
            lblLastName2.Text = tbxLastName.Text;
            lblTelerhoneNum2.Text = tbxTelNum.Text;
            lblEmail2.Text = tbxEmail.Text;
            lblDeliveryAddress2.Text = tbxAdress.Text;
            lblMethodOfPayment2.Text = ddlMethodOfPayment.SelectedItem.Value;
            lblTotal2.Text = GetLocalResourceObject("lblTotal2Resource1.Text").ToString() + string.Format("{0:0.00}$", Profile.ShoppingCart.Total);
        }
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        int newOrderID;
        if (Profile.ShoppingCart.OrderID > 0)
        {
            newOrderID = Profile.ShoppingCart.OrderID;
            Order.UpdateAllOrder(newOrderID, Profile.ShoppingCart, lblMethodOfPayment2.Text, lblDeliveryAddress2.Text, lblEmail2.Text, lblTelerhoneNum2.Text, "", "");
        }
        else
        {
            newOrderID = Order.InsertOrder(Profile.ShoppingCart, lblMethodOfPayment2.Text, lblDeliveryAddress2.Text, lblEmail2.Text, lblTelerhoneNum2.Text, "");
        }

        Profile.ShoppingCart.Clear();
        Response.Redirect("~/OrderDetails.aspx?orderID=" + newOrderID.ToString());
    }

    private void UpdateTotal()
    {
        foreach (GridViewRow row in gridCart.Rows)
        {
            int id = Convert.ToInt32(gridCart.DataKeys[row.RowIndex][0]);
            int quantity = Convert.ToInt32((row.FindControl("tbxQuantity") as TextBox).Text);
            Profile.ShoppingCart.UpdateItemQuantity(id, quantity);
        }
        lblPrice.Text = GetLocalResourceObject("lblPriceResource1.Text").ToString() + string.Format("{0:0.00}$", Profile.ShoppingCart.Total);
        lblDiscount.Text = GetLocalResourceObject("lblDiscountResource1.Text").ToString() + string.Format("{0}%", Profile.ShoppingCart.AuthorizedDiscount);
        lblTotal.Text = GetLocalResourceObject("lblTotalResource1.Text").ToString() + string.Format("Total Price: {0:0.00}$", Profile.ShoppingCart.TotalWithDiscount);
        gridCart.DataBind();
    }
    protected void gridCart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Profile.ShoppingCart.DeleteProduct(Convert.ToInt32(e.CommandArgument));
        UpdateTotal();
    }
    protected void gridCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
}
