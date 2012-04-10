using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

public partial class Controls_MyCheckBoxList : System.Web.UI.UserControl
{
    private List<int> deps = new List<int>();
    public List<int> departmentID
    {
        get { return deps; }
        set { }
    }

    public string departments
    {
        get { return Servise.GetDepartmentsString(departmentID); }
        set { }
    }

    private int productID = 0;
    public int ProductID
    {
        get { return productID; }
        set { productID = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void chbxDepartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem item in chbxDepartments.Items)
        {
            if (item.Selected)
                departmentID.Add(Convert.ToInt32(item.Value));
        }
    }
    protected void chbxDepartments_DataBound(object sender, EventArgs e)
    {
        List<int> departments = Department.GetDepartmentsFromProductDepartment(ProductID);
        foreach (ListItem item in chbxDepartments.Items)
        {
            item.Selected = departments.Contains(Convert.ToInt32(item.Value));
        }
    }
}