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
    /// <summary>
    /// 
    /// </summary>
    public class Department
    {
        /// <summary>
        /// Returns a collection with all the departments
        /// </summary>
        /// <returns></returns>
        public static List<DepartmentData> GetDepartments()
        {
            return (new Sql_Provider()).GetDepartments();

        }

        /// <summary>
        /// Returns a department with the specified ID
        /// </summary>
        /// <param name="departmentID"></param>
        /// <returns></returns>
        public static DepartmentData GetDepartmentByID(int departmentID)
        {
            return (new Sql_Provider()).GetDepartment(departmentID);
        }

        public static List<int> GetDepartmentsFromProductDepartment(int productID)
        {
            return new Sql_Provider().GetDepartmentsFromProductDepartment(productID);
        }

        /// <summary>
        /// Updates department
        /// </summary>
        /// <param name="id"></param>
        /// <param name="title"></param>
        /// <param name="importance"></param>
        /// <param name="description"></param>
        /// <param name="imageUrl"></param>
        /// <returns></returns>
        public static bool UpdateDepartment(int id, string title, int importance, string description, string imageUrl)
        {
            return (new Sql_Provider()).UpdateDepartment(new DepartmentData(id, DateTime.Now, "", title, importance, description, imageUrl));
        }

        /// <summary>
        /// Deletes department
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteDepartment(int id)
        {
            return (new Sql_Provider()).DeleteDepartment(id);
        }

        /// <summary>
        /// Creates new department
        /// </summary>
        /// <param name="title"></param>
        /// <param name="importance"></param>
        /// <param name="description"></param>
        /// <param name="imageUrl"></param>
        /// <returns></returns>
        public static int InsertDepartment(string title, int importance, string description, string imageUrl)
        {
            string userName = Servise.GetCurrentUserName();
            return (new Sql_Provider()).InsertDepartment(new DepartmentData(0, DateTime.Now,
                userName, title, importance, description, imageUrl));
        }
    }
}