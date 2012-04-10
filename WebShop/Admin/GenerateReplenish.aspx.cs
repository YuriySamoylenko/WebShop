using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Globalization;
using BLL;

public partial class Admin_GenerateReplenish : System.Web.UI.Page
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

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        tbxAmount.ReadOnly = true;
        tbxKey.Text = Replenish.GenerateKey(Convert.ToDecimal(tbxAmount.Text));
        btnSendKey.Enabled = true;
        lblResult.Visible = false;
    }

    protected void btnSendKey_Click(object sender, EventArgs e)
    {
        Replenish.InsertKey(tbxKey.Text, Convert.ToDecimal(tbxAmount.Text));
        SendMail();
    }

    protected void SendMail()
    {
        MembershipUserCollection users;
        users = Membership.GetAllUsers();
        MembershipUser customer = users[ddlUsers.SelectedValue];

        ProfileCommon usersProfile = Profile.GetProfile(customer.UserName);
        Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(usersProfile.Language);

        MailMessage message = new MailMessage();
        message.To.Add(customer.Email);
        message.Subject = GetLocalResourceObject("ShopName.Text").ToString();
        message.BodyEncoding = Encoding.UTF7;
        message.IsBodyHtml = true;

        message.Body = GetLocalResourceObject("lblResultMail1.Text").ToString() + tbxKey.Text + "<br />" + GetLocalResourceObject("lblResultMail2.Text").ToString() + tbxAmount.Text;

        message.SubjectEncoding = Encoding.GetEncoding(0);

        SmtpClient smtp = new SmtpClient();

        smtp.Send(message);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["Lang"].ToString());
        lblResult.Text = GetLocalResourceObject("lblResultResource2.Text").ToString() + customer.UserName;
        lblResult.Visible = true;
    }
}