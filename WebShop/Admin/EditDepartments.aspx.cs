using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;

public partial class Admin_EditDepartments : System.Web.UI.Page
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
    protected void GridDepaertments_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsDepartment.ChangeMode(DetailsViewMode.Edit);
    }
    protected void DetailsDepartment_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridDepaertments.SelectedIndex = -1;
        GridDepaertments.DataBind();
    }

    protected void DetailsDepartment_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridDepaertments.SelectedIndex = -1;
        GridDepaertments.DataBind();
    }
}