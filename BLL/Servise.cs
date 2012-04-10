using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace BLL
{
    /// <summary>
    /// Summary description for Servise
    /// </summary>
    public class Servise
    {
        public static string ConvertNullToEmptyString(string input)
        {
            return (input == null ? "" : input);
        }

        public static string GetCurrentUserName()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string userName = HttpContext.Current.User.Identity.Name;
                return userName;
            }
            return "";
        }

        public static string GetDepartmentsString(List<int> list)
        {
            string result = "";
            if (list.Count > 0)
            {
                foreach (int num in list)
                {
                    if (result.Length == 0)
                    {
                        result += num;
                    }
                    else
                    {
                        result += " " + num;
                    }
                }
            }
            return result;
        }

        public static List<int> GetListDepartmentsID(string input)
        {
            List<int> result = new List<int>();
            if (input != null)
            {
                string[] strs = input.Split(new char[] { ' ' });
                foreach (string str in strs)
                {
                    result.Add(Convert.ToInt32(str));
                }
            }

            return result;
        }

        public static List<UsersNamesList> GetUsers()
        {
            MembershipUserCollection users = Membership.GetAllUsers();
            List<UsersNamesList> list = new List<UsersNamesList>();
            foreach (MembershipUser user in users)
            {
                UsersNamesList usnames = new UsersNamesList();
                usnames.UserName = user.UserName;
                list.Add(usnames);
            }
            return list;
        }

        public Servise()
        {
        }
    }

    public class UsersNamesList
    {
        public string UserName { get; set; }
    }
}