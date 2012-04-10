using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text;
using System.Transactions;
using DAL;

namespace BLL
{
    /// <summary>
    /// 
    /// </summary>
    public class Order
    {
        /// <summary>
        /// Returns a collection with all the order in a specified state, and within
        /// the specified range of date
        /// </summary>
        /// <param name="statusID"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        /// <returns></returns>
        public static List<OrdersData> GetOrders(int statusID, DateTime fromDate, DateTime toDate)
        {
            return (new Sql_Provider()).GetOrdersByStatus(statusID, fromDate, toDate);
        }

        /// <summary>
        /// Returns a collection with all the order for the specified customer
        /// </summary>
        /// <param name="customerName"></param>
        /// <returns></returns>
        public static List<OrdersData> GetOrdersByCustomer(string customerName)
        {
            return (new Sql_Provider()).GetOrdersByCustomer(customerName);
        }

        /// <summary>
        /// Returns an order with the specified ID
        /// </summary>
        /// <param name="orderID"></param>
        /// <returns></returns>
        public static OrdersData GetOrderByID(int orderID)
        {
            return (new Sql_Provider()).GetOrdersByID(orderID);
        }

        /// <summary>
        /// Updates order
        /// </summary>
        /// <param name="id"></param>
        /// <param name="statusID"></param>
        /// <param name="shippedDate"></param>
        /// <param name="transactionID"></param>
        /// <param name="trackingID"></param>
        /// <returns></returns>
        public static bool UpdateOrder(int id, int statusID, DateTime shippedDate, string transactionID, string trackingID)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                transactionID = Servise.ConvertNullToEmptyString(transactionID);
                trackingID = Servise.ConvertNullToEmptyString(trackingID);

                OrdersData order = Order.GetOrderByID(id);
                bool ret = (new Sql_Provider()).UpdateOrder(new OrdersData(id, DateTime.Now, "", statusID, "", "", 0.0m,
                    "", "", "", transactionID, trackingID, true));

                scope.Complete();
                return ret;
            }
        }

        public static bool UpdateAllOrder(int id, ShoppingCart shoppingCart, string methodOfPayment,
            string deliveryAddress, string eMail, string phone, string transactionID, string trackingID)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                transactionID = Servise.ConvertNullToEmptyString(transactionID);
                trackingID = Servise.ConvertNullToEmptyString(trackingID);

                OrdersData order = Order.GetOrderByID(id);
                bool ret = (new Sql_Provider()).UpdateAllOrder(new OrdersData(id, DateTime.Now, "", 1, "", methodOfPayment, shoppingCart.TotalWithDiscount,
                    deliveryAddress, eMail, phone, transactionID, trackingID, true));

                scope.Complete();
                return ret;
            }
        }

        public static bool UpdateOrdersPaid(int orderID, bool paid)
        {
            return (new Sql_Provider()).UpdateOrdersPaid(orderID, paid);
        }

        /// <summary>
        /// Deletes order
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteOrder(int id)
        {
            return (new Sql_Provider()).DeleteOrder(id);
        }

        /// <summary>
        /// Creates new order
        /// </summary>
        /// <param name="shoppingCart"></param>
        /// <param name="methodOfPayment"></param>
        /// <param name="shipping"></param>
        /// <param name="shippingFirstName"></param>
        /// <param name="shippingLastName"></param>
        /// <param name="shippingStreet"></param>
        /// <param name="shippingPostalCode"></param>
        /// <param name="shippingCity"></param>
        /// <param name="shippingState"></param>
        /// <param name="shippingCountry"></param>
        /// <param name="customerEmail"></param>
        /// <param name="customerPhone"></param>
        /// <param name="customerFax"></param>
        /// <param name="transactionID"></param>
        /// <returns></returns>
        public static int InsertOrder(ShoppingCart shoppingCart,
             string methodOfPayment, string deliveryAddress, string customerEmail, string customerPhone, string transactionID)
        {
            int orderID;
            string userName = Servise.GetCurrentUserName();

            using (TransactionScope scope = new TransactionScope())
            {
                orderID = (new Sql_Provider()).InsertOrder(new OrdersData(0, DateTime.Now,
                   userName, 1, "", methodOfPayment, shoppingCart.TotalWithDiscount, deliveryAddress,
                   customerEmail, customerPhone,
                   transactionID, "", false));

                scope.Complete();
            }

            foreach (ShoppingCartItem item in shoppingCart.Items)
            {
                (new Sql_Provider()).InsertOrderItem(new OrderItemsData(0, DateTime.Now, userName, orderID, item.ProductID, item.Title, "", item.UnitPrice, item.Quantity));
            }

            return orderID;
        }
    }
}