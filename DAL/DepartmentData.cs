using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace DAL
{
    public class DepartmentData
    {
        public DepartmentData() { }

        public DepartmentData(int id, DateTime addedDate, string addedBy, string title, int importance, string description, string imageUrl)
        {
            this.ID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.Title = title;
            this.Importance = importance;
            this.Description = description;
            this.ImageUrl = imageUrl;
        }

        public int ID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public string Title { get; set; }

        public int Importance { get; set; }

        public string Description { get; set; }

        public string ImageUrl { get; set; }
    }

    public class ProductDepartment
    {
        public ProductDepartment() { }

        public ProductDepartment(int productID, int departmentID)
        {
            ProductID = productID;
            DepartmentID = departmentID;
        }

        public int ProductID { get; set; }

        public int DepartmentID { get; set; }
    }
}