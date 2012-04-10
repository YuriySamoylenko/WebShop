using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;

namespace BLL
{
    /// <summary>
    /// Summary description for ShopProfit
    /// </summary>
    public class ShopProfit
    {
        public static List<ShopProfitData> GetProfit(string sortExpression, DateTime fromDate, DateTime toDate)
        {
            return (new Sql_Provider()).GetProfits(sortExpression, fromDate, toDate);
        }

        public static List<Sales> GetSales(DateTime fromDate, DateTime toDate)
        {
            return (new Sql_Provider()).GetSales("", fromDate, toDate);
        }

        public static int InsertShopProfit(int orderID, decimal money)
        {
            return (new Sql_Provider()).InsertProfit(new ShopProfitData(0, DateTime.Now, orderID, money));
        }
    }
}