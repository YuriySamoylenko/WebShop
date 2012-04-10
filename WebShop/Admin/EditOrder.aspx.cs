using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Web.Security;
using System.Text;
using System.Threading;
using System.Globalization;
using System.Web.Profile;
using BLL;
using DAL;

public partial class Admin_EditOrder : System.Web.UI.Page
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
        if (!string.IsNullOrEmpty(Request.QueryString["orderID"]))
        {
            OrdersData order = Order.GetOrderByID(Convert.ToInt32(Request.QueryString["orderID"]));
            if (order.StatusID == (int)StatusCode.Canceled || order.StatusID == (int)StatusCode.Delivered ||
                order.StatusID == (int)StatusCode.Unexecuted)
            {
                btnChangeStatus.Visible = false;
            }
        }
    }

    protected void SendMail()
    {
        lblResult.Visible = true;

        OrdersData order = (new Sql_Provider()).GetOrdersByID((int)DetailsView1.DataKey.Value);
        MembershipUserCollection users;
        users = Membership.GetAllUsers();
        MembershipUser customer = users[order.AddedBy];

        ProfileCommon currProf = Profile.GetProfile(customer.UserName);

        Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(currProf.Language);

        MailMessage message = new MailMessage();
        message.To.Add(customer.Email);
        message.Subject = GetLocalResourceObject("ShopName.Text").ToString();
        message.BodyEncoding = Encoding.UTF7;
        message.Body = GetLocalResourceObject("lblResultMail1.Text").ToString() + DetailsView1.DataKey.Value + GetLocalResourceObject("lblResultMail2.Text").ToString() + ddlStatuses.SelectedItem.Text;
        
        message.SubjectEncoding = Encoding.GetEncoding(0);

        SmtpClient smtp = new SmtpClient();

        smtp.Send(message);

        Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["Lang"].ToString());

        lblResult.Text += GetLocalResourceObject("lblResultResource2.Text").ToString();
    }
    protected void btnChangeStatus_Click(object sender, EventArgs e)
    {
        Order.UpdateOrder((int)DetailsView1.DataKey.Value, Convert.ToInt32(ddlStatuses.SelectedItem.Value), DateTime.MinValue, "", "");
        DetailsView1.DataBind();
        OrdersData order = (new Sql_Provider()).GetOrdersByID((int)DetailsView1.DataKey.Value);
        if (order.MethodOfPayment == "Internal" & order.StatusID == (int)StatusCode.Delivered & order.Paid == true)
        {
            ShopProfit.InsertShopProfit(order.ID, order.SubTotal / 2);
        }

        if (order.MethodOfPayment == "CreditCard" & order.StatusID == (int)StatusCode.Delivered & order.Paid == true)
        {
            ShopProfit.InsertShopProfit(order.ID, order.SubTotal / 10);
        }

        SendMail();
    }
}
