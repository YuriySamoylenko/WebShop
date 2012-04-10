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
    public class ProductData
    {
        public ProductData() { }

        public ProductData(int id, DateTime addedDate, string addedBy,
           string title, string description,
           string sku, decimal unitPrice, int discountPercentage, int unitsInStock,
           string smallImageUrl, string fullImageUrl, int votes, int totalRaiting)
        {
            this.ProductID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.Title = title;
            this.Description = description;
            this.SKU = sku;
            this.UnitPrice = unitPrice;
            this.DiscountPercentage = discountPercentage;
            this.UnitsInStock = unitsInStock;
            this.SmallImageUrl = smallImageUrl;
            this.FullImageUrl = fullImageUrl;
            this.Votes = votes;
            this.TotalRaiting = totalRaiting;
        }

        public int ProductID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string SKU { get; set; }

        public decimal UnitPrice { get; set; }

        public int DiscountPercentage { get; set; }

        public int UnitsInStock { get; set; }

        public string SmallImageUrl { get; set; }

        public string FullImageUrl { get; set; }

        public int Votes { get; set; }

        public int TotalRaiting { get; set; }
    }
}