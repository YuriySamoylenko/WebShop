using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Collections;
using DAL;

namespace BLL
{
    [Serializable()]
    public class ShoppingCartItem
    {
        public int ProductID { get; private set; }

        public string Title { get; set; }

        public decimal UnitPrice { get; private set; }

        public decimal TotalPrice
        {
            get { return UnitPrice * Quantity; }
        }

        public int Quantity { get; set; }

        public ShoppingCartItem(int productID, string title, decimal unitPrice, int quantity)
        {
            this.ProductID = productID;
            this.Title = title;
            this.UnitPrice = unitPrice;
            this.Quantity = quantity;
        }
    }

    [Serializable()]
    public class ShoppingCart
    {
        private Dictionary<int, ShoppingCartItem> items = new Dictionary<int, ShoppingCartItem>();
        public ICollection Items
        {
            get { return items.Values; }
        }

        public int ItemsCount
        {
            get { return items.Count; }
        }

        public override bool Equals(object obj)
        {
            return base.Equals(obj);
        }
        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public int OrderID { get; set; }

        public decimal Total
        {
            get
            {
                decimal sum = 0.0m;
                foreach (ShoppingCartItem item in items.Values)
                    sum += item.UnitPrice * item.Quantity;
                return sum;
            }
        }

        public int AuthorizedDiscount
        {
            get
            {
                if (HttpContext.Current.User.IsInRole("AuthorizedUser")) return 5;
                if (HttpContext.Current.User.IsInRole("ElectedUser")) return 10;
                return 0;
            }
        }

        public decimal TotalWithDiscount
        {
            get
            {
                return (Total - ((Total * AuthorizedDiscount) / 100));
            }
        }

        /// <summary>
        /// Removes an item UNIT from the shopping cart
        /// </summary>
        public void DeleteItem(int id)
        {
            if (items.ContainsKey(id))
            {
                ShoppingCartItem item = items[id];
                item.Quantity -= 1;
                if (item.Quantity == 0)
                    items.Remove(id);
            }
        }

        public void DeleteProduct(int id)
        {
            if (items.ContainsKey(id))
                items.Remove(id);
        }

        public void UpdateItemQuantity(int id, int quantity)
        {
            if (items.ContainsKey(id))
            {
                ShoppingCartItem item = items[id];
                item.Quantity = quantity;
                if (item.Quantity <= 0)
                    items.Remove(id);
            }
        }

        public void Clear()
        {
            items.Clear();
            OrderID = 0;
        }

        /// <summary>
        /// Adds a new item to the shopping cart
        /// </summary>
        public void InsertItem(int id, string title, decimal unitPrice, int quantity)
        {
            if (items.ContainsKey(id))
                items[id].Quantity += 1;
            else
                items.Add(id, new ShoppingCartItem(id, title, unitPrice, quantity));
        }
    }


}