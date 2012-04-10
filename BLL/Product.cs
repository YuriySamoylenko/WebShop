using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;

namespace BLL
{
    /// <summary>
    /// Summary description for Product
    /// </summary>
    [Serializable()]
    public class Product
    {
        public int ID { get; set; }

        public DateTime AddedDate { get; set; }

        public string AddedBy { get; set; }

        public string DepartmentID { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string SKU { get; set; }

        public decimal UnitPrice { get; set; }

        public int DiscountPercentage { get; set; }

        public decimal FinalUnitPrice
        {
            get
            {
                if (this.DiscountPercentage > 0)
                    return this.UnitPrice - (this.UnitPrice * this.DiscountPercentage / 100);
                else
                    return this.UnitPrice;
            }
        }

        public int UnitsInStock { get; set; }

        public string SmallImageUrl { get; set; }

        public string FullImageUrl { get; set; }

        public int Votes { get; set; }

        public int TotalRaiting { get; set; }

        public Product(int id, DateTime addedDate, string addedBy, string departmentID,
           string title, string description,
           string sku, decimal unitPrice, int discountPercentage, int unitsInStock,
           string smallImageUrl, string fullImageUrl, int votes, int totalRaiting)
        {
            this.ID = id;
            this.AddedDate = addedDate;
            this.AddedBy = addedBy;
            this.DepartmentID = departmentID;
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

        /// <summary>
        /// Returns a collection with all products
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public static List<Product> GetProducts(string sortExpression, string order)
        {
            List<Product> products = new List<Product>();
            List<ProductData> prodsData = new List<ProductData>();
            Sql_Provider provider = new Sql_Provider();
            prodsData = provider.GetProducts(sortExpression, order);
            foreach (ProductData prodData in prodsData)
            {
                products.Add(new Product(prodData.ProductID, prodData.AddedDate,
                    prodData.AddedBy, null,
                    prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                    prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                    prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting));
            }
            return products;
        }

        /// <summary>
        /// Returns products between specified dates
        /// </summary>
        /// <returns></returns>
        public static List<Product> GetProductsByDate(DateTime from, DateTime to)
        {
            if (from == null)
                from = DateTime.Now;
            if (to == null)
                to = DateTime.Now;
            List<ProductData> prods = (new Sql_Provider()).GetProducts(from, to);
            List<Product> products = new List<Product>();
            foreach (ProductData prodData in prods)
            {
                Product product = new Product(prodData.ProductID, prodData.AddedDate,
                        prodData.AddedBy, null,
                        prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                        prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                        prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting);
                products.Add(product);
            }
            return products;
        }

        /// <summary>
        /// Returns a collection with all products for the specified department
        /// </summary>
        /// <param name="departmentID"></param>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public static List<Product> GetProductsByDepartment(int departmentID, string sortExpression, string order)
        {
            if (departmentID <= 0)
            {
                return GetProducts(sortExpression, order);
            }


            List<Product> products = new List<Product>();
            List<ProductData> prodsData = new List<ProductData>();
            Sql_Provider provider = new Sql_Provider();
            prodsData = provider.GetProductsByDepartment(departmentID, sortExpression);
            foreach (ProductData prodData in prodsData)
            {
                products.Add(new Product(prodData.ProductID, prodData.AddedDate,
                    prodData.AddedBy, null,
                    prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                    prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                    prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting));
            }
            return products;

        }

        /// <summary>
        /// Returns the number of total products
        /// </summary>
        /// <returns></returns>
        public static int GetProductCount()
        {
            return (new Sql_Provider()).GetProductCount();
        }

        /// <summary>
        /// Returns the number of total products for the specified department
        /// </summary>
        /// <param name="departmentID"></param>
        /// <returns></returns>
        public static int GetProductCountByDepartment(int departmentID)
        {
            if (departmentID <= 0)
                return GetProductCount();

            return (new Sql_Provider()).GetProductCountByDepartment(departmentID);
        }

        /// <summary>
        /// Returns product with the specified ID
        /// </summary>
        /// <param name="productID"></param>
        /// <returns></returns>
        public static Product GetProductByID(int productID)
        {
            ProductData prodData = (new Sql_Provider()).GetProductByID(productID);
            Product product = new Product(prodData.ProductID, prodData.AddedDate,
                    prodData.AddedBy, null,
                    prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                    prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                    prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting);
            return product;
        }

        /// <summary>
        /// Returns product with the specified name
        /// </summary>
        /// <param name="title"></param>
        /// <returns></returns>
        public static List<Product> GetProductByName(string title)
        {
            List<ProductData> prods = (new Sql_Provider()).GetProductsByName(title);
            List<Product> products = new List<Product>();
            foreach (ProductData prodData in prods)
            {
                Product product = new Product(prodData.ProductID, prodData.AddedDate,
                        prodData.AddedBy, null,
                        prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                        prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                        prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting);
                products.Add(product);
            }
            return products;
        }

        /// <summary>
        /// Updates product
        /// </summary>
        /// <param name="id"></param>
        /// <param name="departmentID"></param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="sku"></param>
        /// <param name="unitPrice"></param>
        /// <param name="discountPercentage"></param>
        /// <param name="unitsInStock"></param>
        /// <param name="smallImageUrl"></param>
        /// <param name="fullImageUrl"></param>
        /// <returns></returns>
        public static bool UpdateProduct(int id, string departmentID, string title,
             string description, string sku, decimal unitPrice, int discountPercentage,
             int unitsInStock, string smallImageUrl, string fullImageUrl)
        {
            title = Servise.ConvertNullToEmptyString(title);
            description = Servise.ConvertNullToEmptyString(description);
            sku = Servise.ConvertNullToEmptyString(sku);
            smallImageUrl = Servise.ConvertNullToEmptyString(smallImageUrl);
            fullImageUrl = Servise.ConvertNullToEmptyString(fullImageUrl);

            ProductData record = new ProductData(id, DateTime.Now, "", title, description, sku, unitPrice, discountPercentage, unitsInStock,
                smallImageUrl, fullImageUrl, 0, 0);
            return (new Sql_Provider()).UpdateProduct(record, Servise.GetListDepartmentsID(departmentID));
        }

        /// <summary>
        /// Creates new product
        /// </summary>
        /// <param name="departmentID"></param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="sku"></param>
        /// <param name="unitPrice"></param>
        /// <param name="discountPercentage"></param>
        /// <param name="unitsInStock"></param>
        /// <param name="smallImageUrl"></param>
        /// <param name="fullImageUrl"></param>
        /// <returns></returns>
        public static int InsertProduct(string departmentID, string title,
             string description, string sku, decimal unitPrice, int discountPercentage,
             int unitsInStock, string smallImageUrl, string fullImageUrl)
        {
            title = Servise.ConvertNullToEmptyString(title);
            description = Servise.ConvertNullToEmptyString(description);
            sku = Servise.ConvertNullToEmptyString(sku);
            smallImageUrl = Servise.ConvertNullToEmptyString(smallImageUrl);
            fullImageUrl = Servise.ConvertNullToEmptyString(fullImageUrl);

            string userName = Servise.GetCurrentUserName();

            ProductData record = new ProductData(0, DateTime.Now, userName,
                title, description, sku, unitPrice, discountPercentage,
                unitsInStock, smallImageUrl, fullImageUrl, 0, 0);
            return (new Sql_Provider()).InsertProduct(record, Servise.GetListDepartmentsID(departmentID));
        }

        /// <summary>
        /// Deletes product
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteProduct(int id)
        {
            return (new Sql_Provider()).DeleteProduct(id);
        }

        /// <summary>
        /// Decrements product units in stock
        /// </summary>
        /// <param name="id"></param>
        /// <param name="quantitu"></param>
        /// <returns></returns>
        public static bool DecrementProductUnitsInStock(int id, int quantitu)
        {
            return (new Sql_Provider()).DecrementProductUnitsInStock(id, quantitu);
        }


        /// <summary>
        /// Returns first five elements in sorted collection of all products
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <returns></returns>
        public static List<Product> GetFirstProducts(string sortExpression)
        {
            List<Product> products = new List<Product>();
            List<ProductData> prodsData = new List<ProductData>();
            Sql_Provider provider = new Sql_Provider();
            prodsData = provider.GetFirstProducts(sortExpression);
            int count = prodsData.Count;
            if (count > 5) count = 5;
            for (int i = 0; i < count; i++)
            {
                ProductData prodData = prodsData[i];
                products.Add(new Product(prodData.ProductID, prodData.AddedDate,
                    prodData.AddedBy, null,
                    prodData.Title, prodData.Description, prodData.SKU, prodData.UnitPrice,
                    prodData.DiscountPercentage, prodData.UnitsInStock, prodData.SmallImageUrl,
                    prodData.FullImageUrl, prodData.Votes, prodData.TotalRaiting));
            }
            return products;
        }

        public static void UpdateProductRating(int productID, int rating)
        {
            new Sql_Provider().UpdateProductRating(productID, rating);
        }
    }
}