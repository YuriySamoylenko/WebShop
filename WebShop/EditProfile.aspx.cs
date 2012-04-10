using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using System.Transactions;
using BLL;

public partial class EditProfile : System.Web.UI.Page
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
        lblWrongKey.Text = "";
        if (Profile.Money > 0)
        {
            lblScoreValue.Text = string.Format("{0:0.00}$", Profile.Money);
        }
        else
        {
            lblScoreValue.Text = string.Format("{0:0.00}$", 0.0M);
        }
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        lblUpdate.Visible = true;
        ProfileControl1.SaveProfile();
        Session.Add("Lang", Profile.Language);
    }
    protected void btnRechargeScore_Click(object sender, EventArgs e)
    {
        lblEnterCode.Visible = true;
        tbxCode.Visible = true;
        btnEnterCode.Visible = true;
        RegularExpressionValidator1.Visible = true;
        RequiredFieldValidator1.Visible = true;
    }
    protected void btnEnterCode_Click(object sender, EventArgs e)
    {
        List<string> keys = Replenish.GetKeys();

        if (keys.Contains(tbxCode.Text))
        {
            bool result;
            using (TransactionScope scope = new TransactionScope())
            {
                try
                {
                    Profile.Money += Replenish.GetMoneyByKey(tbxCode.Text);
                    result = true;
                }
                catch (Exception)
                {
                    result = false;
                }
            }
            if (result)
            {
                lblWrongKey.Text = GetLocalResourceObject("lblWrongKey1.Text").ToString();
            }
            else
            {
                lblWrongKey.Text = GetLocalResourceObject("lblWrongKey2.Text").ToString();
            }
            Page_Load(null, null);
        }
        else
        {
            lblWrongKey.Text = GetLocalResourceObject("lblWrongKeyResource1.Text").ToString();
        }
    }
}