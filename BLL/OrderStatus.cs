using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;

namespace BLL
{
    /// <summary>
    /// 
    /// </summary>
    public class OrderStatus
    {
        /// <summary>
        /// Returns a collection with all the order statuses
        /// </summary>
        /// <returns></returns>
        public static List<OrderStatusData> GetOrderSatuses()
        {
            return (new Sql_Provider()).GetOrderStatuses();
        }

        /// <summary>
        /// Returns a order status with the specified ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static OrderStatusData GetOrderStatusByID(int id)
        {
            return (new Sql_Provider()).GetOrderStatusByID(id);
        }

        /// <summary>
        /// Updates order status
        /// </summary>
        /// <param name="id"></param>
        /// <param name="title"></param>
        /// <returns></returns>
        public static bool UpdateOrderStatus(int id, string title)
        {
            return (new Sql_Provider()).UpdteOrderStatus(new OrderStatusData(id, DateTime.Now, "", title));
        }

        /// <summary>
        /// Deletes order status
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteOrderStatus(int id)
        {
            return (new Sql_Provider()).DeleteOrderStatus(id);
        }

        /// <summary>
        /// Creates new order status
        /// </summary>
        /// <param name="title"></param>
        /// <returns></returns>
        public static int InsertOrderStatus(string title)
        {
            string userName = Servise.GetCurrentUserName();

            return (new Sql_Provider()).InsertOrderStatus(new OrderStatusData(0, DateTime.Now, userName, title));
        }
    }
}