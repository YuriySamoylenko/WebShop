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
    public class OrderItemsData
    {
        public OrderItemsData() { }

        public OrderItemsData(int id, DateTime addedDate, string addedBy,
         int orderID, int productID, string title, string sku, decimal unitPrice, int quantity)
        {
            this.ID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.OrderID = orderID;
            this.ProductID = productID;
            this.Title = title;
            this.SKU = sku;
            this.UnitPrice = unitPrice;
            this.Quantity = quantity;
        }

        public int ID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public int OrderID { get; set; }

        public int ProductID { get; set; }

        public string Title { get; set; }

        public string SKU { get; set; }

        public decimal UnitPrice { get; set; }

        public int Quantity { get; set; }
    }
}