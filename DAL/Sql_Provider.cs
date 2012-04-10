using System;
using System.Data;
//using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Caching;

namespace DAL
{
    public class Sql_Provider
    {
        private string connectionString;

        public Sql_Provider()
        {
            connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        }

        #region Departments

        /// <summary>
        /// Returns a collection with all the departments
        /// </summary>
        /// <param name="departmentID"></param>
        /// <returns></returns>
        public DepartmentData GetDepartment(int departmentID)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetDepartmentByID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int, 4));
                cmd.Parameters["@DepartmentID"].Value = departmentID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);
                reader.Read();
                DepartmentData department = new DepartmentData((int)reader["DepartmentID"], (DateTime)reader["AddedDate"], reader["AddedBy"].ToString(),
                        reader["Tittle"].ToString(), (int)reader["Importance"], reader["Description"].ToString(), reader["ImageUrl"].ToString());
                reader.Close();
                return department;
            }
        }

        /// <summary>
        /// Returns an existing department with the specified ID
        /// </summary>
        /// <returns></returns>
        public List<DepartmentData> GetDepartments()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetDepartments", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<DepartmentData> departments = new List<DepartmentData>();
                while (reader.Read())
                {
                    DepartmentData depData = new DepartmentData((int)reader["DepartmentID"], (DateTime)reader["AddedDate"], reader["AddedBy"].ToString(),
                        reader["Tittle"].ToString(), (int)reader["Importance"], reader["Description"].ToString(), reader["ImageUrl"].ToString());
                    departments.Add(depData);
                }
                reader.Close();
                return departments;

            }
        }

        /// <summary>
        /// Creates a new department
        /// </summary>
        /// <param name="department"></param>
        /// <returns></returns>
        public int InsertDepartment(DepartmentData department)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@AddedDate", DbType.DateTime));
                cmd.Parameters["@AddedDate"].Value = department.AddedDate;
                cmd.Parameters.Add(new SqlParameter("@AddedBy", SqlDbType.NVarChar, 256));
                cmd.Parameters["@AddedBy"].Value = department.AddedBy;
                cmd.Parameters.Add(new SqlParameter("@Tittle", SqlDbType.NVarChar, 256));
                cmd.Parameters["@Tittle"].Value = department.Title;
                cmd.Parameters.Add(new SqlParameter("@Importance", SqlDbType.Int, 4));
                cmd.Parameters["@Importance"].Value = department.Importance;
                cmd.Parameters.Add(new SqlParameter("@Description", SqlDbType.NVarChar, 400));
                cmd.Parameters["@Description"].Value = department.Description;
                cmd.Parameters.Add(new SqlParameter("@ImageUrl", SqlDbType.NVarChar, 256));
                cmd.Parameters["@ImageUrl"].Value = department.ImageUrl;
                cmd.Parameters.Add("@DepartmentID", SqlDbType.Int).Direction = ParameterDirection.Output;

                con.Open();
                cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["@DepartmentID"].Value;
            }
        }

        /// <summary>
        /// Deletes a department
        /// </summary>
        /// <param name="departmentID"></param>
        /// <returns></returns>
        public bool DeleteDepartment(int departmentID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int));
                cmd.Parameters["@DepartmentID"].Value = departmentID;

                con.Open();
                int ret = cmd.ExecuteNonQuery();
                con.Close();
                DeleteFromProductDepartmentByDepartment(departmentID);

                return (ret == 1);
            }
        }

        /// <summary>
        /// Updates a department
        /// </summary>
        /// <param name="department"></param>
        /// <returns></returns>
        public bool UpdateDepartment(DepartmentData department)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int, 4));
                cmd.Parameters["@DepartmentID"].Value = department.ID;
                cmd.Parameters.Add(new SqlParameter("@Tittle", SqlDbType.NVarChar, 256));
                cmd.Parameters["@Tittle"].Value = department.Title;
                cmd.Parameters.Add(new SqlParameter("@Importance", SqlDbType.Int, 4));
                cmd.Parameters["@Importance"].Value = department.Importance;
                cmd.Parameters.Add(new SqlParameter("@Description", SqlDbType.NVarChar, 4000));
                cmd.Parameters["@Description"].Value = department.Description;
                cmd.Parameters.Add(new SqlParameter("@ImageUrl", SqlDbType.NVarChar, 256));
                cmd.Parameters["@ImageUrl"].Value = department.ImageUrl;

                con.Open();
                int ret = cmd.ExecuteNonQuery();


                return (ret == 1);
            }
        }

        public List<int> GetDepartmentsFromProductDepartment(int productID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetDepartmentsFromProductDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int)).Value = productID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<int> departments = new List<int>();
                while (reader.Read())
                {
                    departments.Add((int)reader["DepartmentID"]);
                }
                return departments;
            }
        }

        #endregion

        #region ProductDepartment

        /// <summary>
        /// Insert record in the table ProductDepartment
        /// </summary>
        /// <param name="depsList"></param>
        public void InsertToProductDepartment(int productID, List<int> depsIDList) //InsertInProductDepartment
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                foreach (int departmentID in depsIDList)
                {
                    SqlCommand cmd = new SqlCommand("InsertInProductDepartment", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int)).Value = productID;
                    cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int)).Value = departmentID;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        public void DeleteFromProductDepartmentByProduct(int productID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteFromProductDepartmentByProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int)).Value = productID;

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void DeleteFromProductDepartmentByDepartment(int departmentID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteFromProductDepartmentByDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int)).Value = departmentID;

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        #endregion

        #region Products

        /// <summary>
        /// Returns the product with the specified ID
        /// </summary>
        /// <param name="productID"></param>
        /// <returns></returns>
        public ProductData GetProductByID(int productID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetProductByID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int));
                cmd.Parameters["@ProductID"].Value = productID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);
                reader.Read();
                ProductData product = new ProductData((int)reader["ProductID"],
                    (DateTime)reader["AddedDate"],
                    reader["AddedBy"].ToString(),
                    reader["Title"].ToString(),
                    reader["Description"].ToString(),
                    reader["SKU"].ToString(),
                    (decimal)reader["UnitPrice"],
                    (int)reader["DiscountPercentage"],
                    (int)reader["UnitsInStock"],
                    reader["SmallImageUrl"].ToString(),
                    reader["FullImageUrl"].ToString(),
                    0,
                    (int)reader["TotalRaiting"]);
                reader.Close();
                return product;
            }
        }

        public List<ProductData> GetProductsByName(string title)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM tbl_Products WHERE Title = @Title", con);
                cmd.Parameters.Add(new SqlParameter("@Title", SqlDbType.NVarChar));
                cmd.Parameters["@Title"].Value = title;

                con.Open();
                List<ProductData> products = new List<ProductData>();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ProductData product = new ProductData((int)reader["ProductID"],
                        (DateTime)reader["AddedDate"],
                        reader["AddedBy"].ToString(),
                        reader["Title"].ToString(),
                        reader["Description"].ToString(),
                        reader["SKU"].ToString(),
                        (decimal)reader["UnitPrice"],
                        (int)reader["DiscountPercentage"],
                        (int)reader["UnitsInStock"],
                        reader["SmallImageUrl"].ToString(),
                        reader["FullImageUrl"].ToString(),
                        0,
                        (int)reader["TotalRaiting"]);
                    products.Add(product);
                }
                reader.Close();
                return products;
            }
        }

        public List<ProductData> GetProducts(DateTime from, DateTime to)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM tbl_Products WHERE AddedDate BETWEEN @From AND @To", con);
                cmd.Parameters.Add(new SqlParameter("@From", SqlDbType.DateTime)).Value = from;
                cmd.Parameters.Add(new SqlParameter("@To", SqlDbType.DateTime)).Value = to;

                con.Open();
                List<ProductData> products = new List<ProductData>();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ProductData product = new ProductData((int)reader["ProductID"],
                        (DateTime)reader["AddedDate"],
                        reader["AddedBy"].ToString(),
                        reader["Title"].ToString(),
                        reader["Description"].ToString(),
                        reader["SKU"].ToString(),
                        (decimal)reader["UnitPrice"],
                        (int)reader["DiscountPercentage"],
                        (int)reader["UnitsInStock"],
                        reader["SmallImageUrl"].ToString(),
                        reader["FullImageUrl"].ToString(),
                        0,
                        (int)reader["TotalRaiting"]);
                    products.Add(product);
                }
                reader.Close();
                return products;
            }
        }

        /// <summary>
        /// Returns a collection with all products
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public List<ProductData> GetProducts(string sortExpression, string order)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                if (sortExpression == null)
                    sortExpression = "";

                SqlCommand cmd = new SqlCommand("GetProducts", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();


                con.Open();
                adapter.Fill(ds, "tbl_Products");

                con.Close();

                DataView view = ds.Tables[0].DefaultView;
                view.Sort = sortExpression + order;

                List<ProductData> products = new List<ProductData>();
                foreach (DataRowView row in view)
                {
                    ProductData product = new ProductData((int)row["ProductID"],
                        (DateTime)row["AddedDate"],
                        row["AddedBy"].ToString(),
                        row["Title"].ToString(),
                        row["Description"].ToString(),
                        row["SKU"].ToString(),
                        (decimal)row["UnitPrice"],
                        (int)row["DiscountPercentage"],
                        (int)row["UnitsInStock"],
                        row["SmallImageUrl"].ToString(),
                        row["FullImageUrl"].ToString(),
                        0,
                        (int)row["TotalRaiting"]);

                    products.Add(product);
                }
                return products;
            }
        }

        /// <summary>
        /// Returns a collection with all products for the specified department
        /// </summary>
        /// <param name="departmentID"></param>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public List<ProductData> GetProductsByDepartment(int departmentID, string sortExpression)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetProductsByDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int)).Value = departmentID;

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                adapter.Fill(ds);
                con.Close();


                DataView view = ds.Tables[0].DefaultView;
                view.Sort = sortExpression;
                //SqlDataReader row = cmd.ExecuteReader();
                List<ProductData> products = new List<ProductData>();
                foreach (DataRowView row in view)
                {
                    ProductData product = new ProductData(
                        (int)row["ProductID"],
                        (DateTime)row["AddedDate"],
                        row["AddedBy"].ToString(),
                        row["Title"].ToString(),
                        row["Description"].ToString(),
                        row["SKU"].ToString(),
                        (decimal)row["UnitPrice"],
                        (int)row["DiscountPercentage"],
                        (int)row["UnitsInStock"],
                        row["SmallImageUrl"].ToString(),
                        row["FullImageUrl"].ToString(),
                        0, (int)row["TotalRaiting"]);
                    products.Add(product);
                }
                return products;
            }
        }

        /// <summary>
        /// Returns the total number of products
        /// </summary>
        /// <returns></returns>
        public int GetProductCount()
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetProductCount", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        /// <summary>
        /// Returns the total number of products for the specified department
        /// </summary>
        /// <param name="departmentID"></param>
        /// <returns></returns>
        public int GetProductCountByDepartment(int departmentID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetProductCountByDepartment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", SqlDbType.Int));
                cmd.Parameters["@DepartmentID"].Value = departmentID;
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        /// <summary>
        /// Inserts a new product
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        public int InsertProduct(ProductData product, List<int> departmentID)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime);
                cmd.Parameters["@AddedDate"].Value = product.AddedDate;
                cmd.Parameters.Add("@AddedBy", SqlDbType.NVarChar);
                cmd.Parameters["@AddedBy"].Value = product.AddedBy;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar);
                cmd.Parameters["@Title"].Value = product.Title;
                cmd.Parameters.Add("@Description", SqlDbType.NText);
                cmd.Parameters["@Description"].Value = product.Description;
                cmd.Parameters.Add("@SKU", SqlDbType.NVarChar);
                cmd.Parameters["@SKU"].Value = product.SKU;
                cmd.Parameters.Add("@UnitPrice", SqlDbType.Money);
                cmd.Parameters["@UnitPrice"].Value = product.UnitPrice;
                cmd.Parameters.Add("@DiscountPercentage", SqlDbType.Int);
                cmd.Parameters["@DiscountPercentage"].Value = product.DiscountPercentage;
                cmd.Parameters.Add("@UnitsInStock", SqlDbType.Int);
                cmd.Parameters["@UnitsInStock"].Value = product.UnitsInStock;
                cmd.Parameters.Add("@SmallImageUrl", SqlDbType.NVarChar);
                cmd.Parameters["@SmallImageUrl"].Value = product.SmallImageUrl;
                cmd.Parameters.Add("@FullImageUrl", SqlDbType.NVarChar);
                cmd.Parameters["@FullImageUrl"].Value = product.FullImageUrl;

                //cmd.Parameters.Add("@Votes", SqlDbType.Int).Value = 0;
                cmd.Parameters.Add("@TotalRating", SqlDbType.Int).Value = 0;

                cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int));
                cmd.Parameters["@ProductID"].Direction = ParameterDirection.Output;

                con.Open();
                cmd.ExecuteNonQuery();

                int ret = (int)cmd.Parameters["@ProductID"].Value;
                con.Close();
                if (departmentID != null) InsertToProductDepartment(ret, departmentID);

                return ret;
            }
        }

        /// <summary>
        /// Deletes a product
        /// </summary>
        /// <param name="productID"></param>
        /// <returns></returns>
        public bool DeleteProduct(int productID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductID", SqlDbType.Int));
                cmd.Parameters["@ProductID"].Value = productID;

                con.Open();
                int ret = cmd.ExecuteNonQuery();

                DeleteFromProductDepartmentByProduct(productID);

                return (ret == 1);
            }
        }

        /// <summary>
        /// Updates a product
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        public bool UpdateProduct(ProductData product, List<int> departmentID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateProduct", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ProductID", SqlDbType.Int);
                cmd.Parameters["@ProductID"].Value = product.ProductID;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar);
                cmd.Parameters["@Title"].Value = product.Title;
                cmd.Parameters.Add("@Description", SqlDbType.NText);
                cmd.Parameters["@Description"].Value = product.Description;
                cmd.Parameters.Add("@SKU", SqlDbType.NVarChar);
                cmd.Parameters["@SKU"].Value = product.SKU;
                cmd.Parameters.Add("@UnitPrice", SqlDbType.Money);
                cmd.Parameters["@UnitPrice"].Value = product.UnitPrice;
                cmd.Parameters.Add("@DiscountPercentage", SqlDbType.Int);
                cmd.Parameters["@DiscountPercentage"].Value = product.DiscountPercentage;
                cmd.Parameters.Add("@UnitsInStock", SqlDbType.Int);
                cmd.Parameters["@UnitsInStock"].Value = product.UnitsInStock;
                cmd.Parameters.Add("@SmallImageUrl", SqlDbType.NVarChar);
                cmd.Parameters["@SmallImageUrl"].Value = product.SmallImageUrl;
                cmd.Parameters.Add("@FullImageUrl", SqlDbType.NVarChar);
                cmd.Parameters["@FullImageUrl"].Value = product.FullImageUrl;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                con.Close();
                if (departmentID.Count > 0)
                {
                    DeleteFromProductDepartmentByProduct(product.ProductID);
                    InsertToProductDepartment(product.ProductID, departmentID);
                }

                return (ret == 1);
            }
        }

        /// <summary>
        /// Decrements the UnitsInStock field of the specified quantity for the specified product
        /// </summary>
        /// <param name="productID"></param>
        /// <param name="quantity"></param>
        /// <returns></returns>
        public bool DecrementProductUnitsInStock(int productID, int quantity)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DecrementUnitsInStock", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ProductID", SqlDbType.Int).Value = productID;
                cmd.Parameters.Add("@Quantity", SqlDbType.Int).Value = quantity;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        /// <summary>
        /// Returns a sorted collection with all products
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public List<ProductData> GetFirstProducts(string sortExpression)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                string sql = string.Format("SELECT * FROM tbl_Products ORDER BY {0} DESC", sortExpression);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<ProductData> products = new List<ProductData>();
                while (reader.Read())
                {
                    ProductData product = new ProductData((int)reader["ProductID"],
                            (DateTime)reader["AddedDate"],
                            reader["AddedBy"].ToString(),
                            reader["Title"].ToString(),
                            reader["Description"].ToString(),
                            reader["SKU"].ToString(),
                            (decimal)reader["UnitPrice"],
                            (int)reader["DiscountPercentage"],
                            (int)reader["UnitsInStock"],
                            reader["SmallImageUrl"].ToString(),
                            reader["FullImageUrl"].ToString(),
                            0, (int)reader["TotalRaiting"]);
                    products.Add(product);
                }
                return products;
            }
        }

        public void UpdateProductRating(int productID, int rating)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateProductRating", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ProductID", SqlDbType.Int);
                cmd.Parameters["@ProductID"].Value = productID;
                cmd.Parameters.Add("@Rating", SqlDbType.Int).Value = rating;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
            }
        }

        #endregion

        #region OrderStatuses

        /// <summary>
        /// Returns a collection with all the order statuses
        /// </summary>
        /// <returns></returns>
        public List<OrderStatusData> GetOrderStatuses()
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrderStatuses", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<OrderStatusData> statuses = new List<OrderStatusData>();
                while (reader.Read())
                {
                    OrderStatusData status = new OrderStatusData((int)reader["OrderStatusID"], (DateTime)reader["AddedDate"], reader["AddedBy"].ToString(),
                        reader["Title"].ToString());
                    statuses.Add(status);
                }
                reader.Close();
                return statuses;
            }
        }

        /// <summary>
        /// Returns an existing order status with the specified ID
        /// </summary>
        /// <param name="orderStatusID"></param>
        /// <returns></returns>
        public OrderStatusData GetOrderStatusByID(int orderStatusID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrderStatusByID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@OrderStatusID", SqlDbType.Int));
                cmd.Parameters["@OrderStatusID"].Value = orderStatusID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                OrderStatusData status = new OrderStatusData((int)reader["OrderStatusID"], (DateTime)reader["AddedDate"], reader["AddedBy"].ToString(),
                    reader["Title"].ToString());
                reader.Close();
                return status;
            }
        }

        /// <summary>
        /// Deletes order status
        /// </summary>
        /// <param name="orderStatusID"></param>
        /// <returns></returns>
        public bool DeleteOrderStatus(int orderStatusID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteOrderStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderStatusID", SqlDbType.Int);
                cmd.Parameters["@OrderStatusID"].Value = orderStatusID;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        /// <summary>
        /// Updates order status
        /// </summary>
        /// <param name="orderStatus"></param>
        /// <returns></returns>
        public bool UpdteOrderStatus(OrderStatusData orderStatus)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("tbh_Store_UpdateOrderStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderStatusID", SqlDbType.Int);
                cmd.Parameters["@OrderStatusID"].Value = orderStatus.ID;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = orderStatus.Title;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        /// <summary>
        /// Returns an existing order status with the specified ID
        /// </summary>
        /// <param name="orderStatus"></param>
        /// <returns></returns>
        public int InsertOrderStatus(OrderStatusData orderStatus)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertOrderStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime).Value = orderStatus.AddedDate;
                cmd.Parameters.Add("@AddedBy", SqlDbType.NVarChar).Value = orderStatus.AddedBy;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = orderStatus.Title;
                cmd.Parameters.Add("@OrderStatusID", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["@OrderStatusID"].Value;
            }
        }

        #endregion

        #region Orders

        /// <summary>
        /// Returns the list of orders for the specified customer
        /// </summary>
        /// <param name="addedBy"></param>
        /// <returns></returns>
        public List<OrdersData> GetOrdersByCustomer(string addedBy)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrdersByCustomer", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedBy", SqlDbType.NVarChar).Value = addedBy;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<OrdersData> orders = new List<OrdersData>();
                while (reader.Read())
                {
                    OrdersData order = new OrdersData((int)reader["OrderID"],
                        (DateTime)reader["AddedDate"],
                        reader["AddedBy"].ToString(),
                        (int)reader["StatusID"],
                        reader["StatusTitle"].ToString(),
                        reader["MethodOfPayment"].ToString(),
                        (decimal)reader["SubTotal"],
                        reader["DeliveryAddress"].ToString(),
                        reader["CustomerEmail"].ToString(),
                        reader["CustomerPhone"].ToString(),
                        reader["TransactionID"].ToString(),
                        reader["TrackingID"].ToString(),
                        (bool)reader["Paid"]);
                    orders.Add(order);
                }
                return orders;
            }
        }

        /// <summary>
        /// Returns the list of orders in the specified state, and within the specified date range
        /// </summary>
        /// <param name="statusID"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        /// <returns></returns>
        public List<OrdersData> GetOrdersByStatus(int statusID, DateTime fromDate, DateTime toDate)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrdersByStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = statusID;
                cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = fromDate;
                cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = toDate;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<OrdersData> orders = new List<OrdersData>();
                while (reader.Read())
                {
                    OrdersData order = new OrdersData((int)reader["OrderID"],
                        (DateTime)reader["AddedDate"],
                        reader["AddedBy"].ToString(),
                        (int)reader["StatusID"],
                        reader["StatusTitle"].ToString(),
                        reader["MethodOfPayment"].ToString(),
                        (decimal)reader["SubTotal"],
                        reader["DeliveryAddress"].ToString(),
                        reader["CustomerEmail"].ToString(),
                        reader["CustomerPhone"].ToString(),
                        reader["TransactionID"].ToString(),
                        reader["TrackingID"].ToString(),
                        (bool)reader["Paid"]);
                }
                return orders;
            }
        }

        /// <summary>
        /// Returns the order with the specified ID
        /// </summary>
        /// <param name="orderID"></param>
        /// <returns></returns>
        public OrdersData GetOrdersByID(int orderID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrderByID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                OrdersData order = new OrdersData((int)reader["OrderID"],
                    (DateTime)reader["AddedDate"],
                    reader["AddedBy"].ToString(),
                    (int)reader["StatusID"],
                    reader["StatusTitle"].ToString(),
                    reader["MethodOfPayment"].ToString(),
                    (decimal)reader["SubTotal"],
                    reader["DeliveryAddress"].ToString(),
                    reader["CustomerEmail"].ToString(),
                    reader["CustomerPhone"].ToString(),
                    reader["TransactionID"].ToString(),
                    reader["TrackingID"].ToString(),
                    (bool)reader["Paid"]);
                return order;
            }
        }

        /// <summary>
        /// Deletes order
        /// </summary>
        /// <param name="orderID"></param>
        /// <returns></returns>
        public bool DeleteOrder(int orderID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("tbh_Store_DeleteOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        /// <summary>
        /// Creates new order
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public int InsertOrder(OrdersData order)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime).Value = order.AddedDate;
                cmd.Parameters.Add("@AddedBy", SqlDbType.NVarChar).Value = order.AddedBy;
                cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = order.StatusID;
                cmd.Parameters.Add("@MethodOfPayment", SqlDbType.NVarChar).Value = order.MethodOfPayment;
                cmd.Parameters.Add("@SubTotal", SqlDbType.Money).Value = order.SubTotal;
                cmd.Parameters.Add("@DeliveryAddress", SqlDbType.NVarChar).Value = order.DeliveryAddress;
                cmd.Parameters.Add("@CustomerEmail", SqlDbType.NVarChar).Value = order.CustomerEmail;
                cmd.Parameters.Add("@CustomerPhone", SqlDbType.NVarChar).Value = order.CustomerPhone;
                cmd.Parameters.Add("@TransactionID", SqlDbType.NVarChar).Value = order.TransactionID;
                cmd.Parameters.Add("@Paid", SqlDbType.Bit).Value = order.Paid;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["@OrderID"].Value;
            }
        }

        /// <summary>
        /// Updates order
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public bool UpdateOrder(OrdersData order)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = order.ID;
                cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = order.StatusID;
                cmd.Parameters.Add("@TransactionID", SqlDbType.NVarChar).Value = order.TransactionID;
                cmd.Parameters.Add("@TrackingID", SqlDbType.NVarChar).Value = order.TrackingID;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        public bool UpdateAllOrder(OrdersData order)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateAllOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = order.ID;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime).Value = order.AddedDate;
                cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = order.StatusID;
                cmd.Parameters.Add("@MethodOfPayment", SqlDbType.NVarChar).Value = order.MethodOfPayment;
                cmd.Parameters.Add("@SubTotal", SqlDbType.Money).Value = order.SubTotal;
                cmd.Parameters.Add("@DeliveryAddress", SqlDbType.NVarChar).Value = order.DeliveryAddress;
                cmd.Parameters.Add("@CustomerEmail", SqlDbType.NVarChar).Value = order.CustomerEmail;
                cmd.Parameters.Add("@CustomerPhone", SqlDbType.NVarChar).Value = order.CustomerPhone;
                cmd.Parameters.Add("@TransactionID", SqlDbType.NVarChar).Value = order.TransactionID;
                cmd.Parameters.Add("@TrackingID", SqlDbType.NVarChar).Value = order.TrackingID;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        public bool UpdateOrdersPaid(int orderID, bool paid)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateOrdersPaid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;
                cmd.Parameters.Add("@Paid", SqlDbType.Bit).Value = paid;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        #endregion

        #region OrderItems

        /// <summary>
        /// Creates new order item
        /// </summary>
        /// <param name="orderItem"></param>
        /// <returns></returns>
        public int InsertOrderItem(OrderItemsData orderItem)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertOrderItem", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime).Value = orderItem.AddedDate;
                cmd.Parameters.Add("@AddedBy", SqlDbType.NVarChar).Value = orderItem.AddedBy;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderItem.OrderID;
                cmd.Parameters.Add("@ProductID", SqlDbType.Int).Value = orderItem.ProductID;
                cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = orderItem.Title;
                cmd.Parameters.Add("@SKU", SqlDbType.NVarChar).Value = orderItem.SKU;
                cmd.Parameters.Add("@UnitPrice", SqlDbType.Money).Value = orderItem.UnitPrice;
                cmd.Parameters.Add("@Quantity", SqlDbType.Int).Value = orderItem.Quantity;
                cmd.Parameters.Add("@OrderItemID", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["@OrderItemID"].Value;
            }
        }

        /// <summary>
        /// Returns collection with all order items for the specified order
        /// </summary>
        /// <param name="orderID"></param>
        /// <returns></returns>
        public List<OrderItemsData> GetOrderItemsByOrderID(int orderID)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetOrderItems", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderID;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                List<OrderItemsData> orderItems = new List<OrderItemsData>();
                while (reader.Read())
                {
                    OrderItemsData orderItem = new OrderItemsData(
                            (int)reader["OrderItemID"],
                            (DateTime)reader["AddedDate"],
                            reader["AddedBy"].ToString(),
                            (int)reader["OrderID"],
                            (int)reader["ProductID"],
                            reader["Title"].ToString(),
                            reader["SKU"].ToString(),
                            (decimal)reader["UnitPrice"],
                            (int)reader["Quantity"]);
                    orderItems.Add(orderItem);
                }
                return orderItems;
            }
        }

        #endregion

        #region ShopProfit

        /// <summary>
        /// Returns the cillection with shop profits
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        /// <returns></returns>
        public List<ShopProfitData> GetProfits(string sortExpression, DateTime fromDate, DateTime toDate)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                if (sortExpression == null)
                    sortExpression = "";
                if (fromDate == null)
                    fromDate = DateTime.MinValue;
                if (toDate == null)
                    toDate = DateTime.MaxValue;

                SqlCommand cmd = new SqlCommand("GetAllFromShopProfit", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@FromDate", SqlDbType.DateTime)).Value = fromDate;
                cmd.Parameters.Add(new SqlParameter("@ToDate", SqlDbType.DateTime)).Value = toDate;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();


                con.Open();
                adapter.Fill(ds, "ShopProfit");

                con.Close();

                DataView view = ds.Tables[0].DefaultView;
                view.Sort = sortExpression;

                List<ShopProfitData> incomes = new List<ShopProfitData>();
                foreach (DataRowView row in view)
                {
                    ShopProfitData income = new ShopProfitData((int)row["ID"], (DateTime)row["AddedDate"],
                        (int)row["OrderID"], (decimal)row["Profit"]);
                    incomes.Add(income);
                }
                return incomes;
            }
        }

        public int InsertProfit(ShopProfitData profit)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertShopProfit", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@AddedDate", SqlDbType.DateTime).Value = profit.Date;
                cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = profit.OrderID;
                cmd.Parameters.Add("@Profit", SqlDbType.Money).Value = profit.Money;
                cmd.Parameters.Add("@ID", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["@ID"].Value;
            }
        }

        /// <summary>
        /// Returns the collection with sold products
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        /// <returns></returns>
        public List<Sales> GetSales(string sortExpression, DateTime fromDate, DateTime toDate)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                if (sortExpression == null)
                    sortExpression = "";
                if (fromDate == null)
                    fromDate = DateTime.MinValue;
                if (toDate == null)
                    toDate = DateTime.MaxValue;

                SqlCommand cmd = new SqlCommand("GetSales", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@FromDate", SqlDbType.DateTime)).Value = fromDate;
                cmd.Parameters.Add(new SqlParameter("@ToDate", SqlDbType.DateTime)).Value = toDate;
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();


                con.Open();
                adapter.Fill(ds, "ShopProfit");

                con.Close();

                DataView view = ds.Tables[0].DefaultView;
                view.Sort = sortExpression;

                List<Sales> incomes = new List<Sales>();
                foreach (DataRowView row in view)
                {
                    Sales income = new Sales((int)row["ID"], (DateTime)row["AddedDate"],
                        (int)row["OrderID"], (string)row["MethodOfPayment"], (int)row["ProductID"], (string)row["Title"], (int)row["Quantity"], (decimal)row["UnitPrice"]);
                    incomes.Add(income);
                }
                return incomes;
            }
        }

        #endregion

        #region Replenish

        public bool InsertKey(ReplenishData record)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("InsertKey", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Key", SqlDbType.NVarChar).Value = record.Key;
                cmd.Parameters.Add("@Money", SqlDbType.Money).Value = record.Money;

                con.Open();
                int ret = cmd.ExecuteNonQuery();
                return (ret == 1);
            }
        }

        public decimal GetMoneyByKey(string key)
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetMoneyByKey", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Key", SqlDbType.NVarChar).Value = key;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);
                reader.Read();

                return (decimal)reader["Cash"];
            }
        }

        public List<string> GetKeys()
        {
            using (SqlConnection con = new SqlConnection(this.connectionString))
            {
                List<string> keys = new List<string>();
                SqlCommand cmd = new SqlCommand("GetKeys", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    keys.Add(reader["ReplKey"].ToString());
                }
                return keys;
            }
        }

        #endregion
    }
}