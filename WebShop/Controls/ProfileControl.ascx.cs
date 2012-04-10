using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_ProfileControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (this.Profile.UserName.Length > 0)
            {
                tbxFirstName.Text = Profile.FirstName;
                tbxLastName.Text = Profile.LastName;
                tbxTelNum.Text = Profile.TelephoneNumber;
                tbxAdress.Text = Profile.Adress;
                ddlLanguage.SelectedValue = Profile.Language;
            }
        }
    }

    public void SaveProfile()
    {
        this.Profile.FirstName = tbxFirstName.Text;
        this.Profile.LastName = tbxLastName.Text;
        this.Profile.TelephoneNumber = tbxTelNum.Text;
        this.Profile.Adress = tbxAdress.Text;
        this.Profile.Language = ddlLanguage.SelectedValue;
    }
}