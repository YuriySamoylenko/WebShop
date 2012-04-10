using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DAL
{
    /// <summary>
    /// Summary description for ShopProfit
    /// </summary>
    public class ShopProfitData
    {
        public ShopProfitData() { }

        public ShopProfitData(int id, DateTime date, int orderID, decimal money)
        {
            ID = id;
            Date = date;
            OrderID = orderID;
            Money = money;
        }

        public int ID { get; set; }

        public DateTime Date { get; set; }

        public int OrderID { get; set; }

        public decimal Money { get; set; }
    }

    /// <summary>
    /// 
    /// </summary>
    public class Sales
    {
        public Sales() { }

        public Sales(int id, DateTime date, int orderID, string methodOfPayment, int productID, string prodTitle, int units, decimal price)
        {
            ID = id;
            Date = date;
            OrderID = orderID;
            MethodOfPayment = methodOfPayment;
            ProductID = productID;
            ProdTitle = prodTitle;
            Units = units;
            Price = price;
        }

        public int ID { get; set; }

        public DateTime Date { get; set; }

        public int OrderID { get; set; }

        public string MethodOfPayment { get; set; }

        public int ProductID { get; set; }

        public string ProdTitle { get; set; }

        public int Units { get; set; }

        public decimal Price { get; set; }
    }

    /// <summary>
    /// 
    /// </summary>
    public class ReplenishData
    {
        public ReplenishData() { }

        public ReplenishData(string key, decimal money)
        {
            Key = key;
            Money = money;
        }

        public string Key { get; set; }

        public decimal Money { get; set; }
    }
}