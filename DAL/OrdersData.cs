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
    public class OrdersData
    {
        public OrdersData() { }

        public OrdersData(int id, DateTime addedDate, string addedBy,
         int statusID, string statusTitle, string methodOfPayment, decimal subTotal,
         string deliveryAddress, string customerEmail, string customerPhone,
         string transactionID, string trackingID, bool paid)
        {
            this.ID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.StatusID = statusID;
            this.StatusTitle = statusTitle;
            this.MethodOfPayment = methodOfPayment;
            this.SubTotal = subTotal;
            this.DeliveryAddress = deliveryAddress;
            this.CustomerEmail = customerEmail;
            this.CustomerPhone = customerPhone;
            this.TransactionID = transactionID;
            this.TrackingID = trackingID;
            Paid = paid;
        }

        public int ID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public int StatusID { get; set; }

        public string StatusTitle { get; set; }

        public string MethodOfPayment { get; set; }

        public decimal SubTotal { get; set; }

        public string DeliveryAddress { get; set; }

        public string CustomerEmail { get; set; }

        public string CustomerPhone { get; set; }

        public string TransactionID { get; set; }

        public string TrackingID { get; set; }

        public bool Paid { get; set; }
    }
}