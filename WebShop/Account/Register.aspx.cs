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
using System.Drawing;
using System.Threading;
using System.Globalization;

public partial class Account_Register : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        if (Session["Lang"] != null)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["Lang"].ToString());
        }
        base.InitializeCulture();
    }
    public static readonly Random rand = new Random();

    protected string PreviousCaptcha { get; private set; }

    protected void UpdateCaptcha()
    {
        const string symbols = "0123456789";
        byte[] rnd = new byte[6];
        char[] chars = new char[6];

        for (int i = 0; i < 6; i++)
            chars[i] = symbols[rand.Next(symbols.Length)];

        HttpContext.Current.Session.Add("Captcha", new String(chars));
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        InitializeCulture();
        if (!IsPostBack)
        {
            UpdateCaptcha();
        }

        UpdatePanel panel = (UpdatePanel)RegisterUserWizardStep.ContentTemplateContainer.FindControl("UpdatePanel1");
        CompareValidator1.ValueToCompare = HttpContext.Current.Session["Captcha"].ToString();
        TextBox tbxCaptcha = (TextBox)panel.FindControl("tbxCaptcha");

        RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        Roles.AddUserToRole(RegisterUser.UserName, "AuthorizedUser");
        MembershipUser user = (Membership.GetAllUsers())[RegisterUser.UserName];
        
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);


        //string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        //if (String.IsNullOrEmpty(continueUrl))
        //{
        //    continueUrl = "~/";
        //}
        //Response.Redirect(continueUrl);
    }

    protected void RegisterUser_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        ProfileControl1.SaveProfile();
        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/";
        }
        Response.Redirect(continueUrl);
    }

    protected void btnCaptcha_Click(object sender, EventArgs e)
    {
        UpdateCaptcha();
        UpdatePanel pan = (UpdatePanel)RegisterUserWizardStep.ContentTemplateContainer.FindControl("UpdatePanel1");
        System.Web.UI.WebControls.Image imgCaptcha = (System.Web.UI.WebControls.Image)pan.FindControl("imgCaptcha");
        imgCaptcha.DataBind();
        pan.DataBind();
        pan.Update();
    }
}
