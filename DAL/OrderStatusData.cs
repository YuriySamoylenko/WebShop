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
    public class OrderStatusData
    {
        public OrderStatusData() { }

        public OrderStatusData(int id, DateTime addedDate, string addedBy, string title)
        {
            this.ID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.Title = title;
        }

        public int ID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public string Title { get; set; }
    }
}