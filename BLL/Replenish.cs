using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Transactions;
using System.Web.Security;
using DAL;

namespace BLL
{
    /// <summary>
    /// Summary description for Replenish
    /// </summary>
    public class Replenish
    {
        public Replenish()
        {

        }

        public static string GenerateKey(decimal money)
        {
            Random rand = new Random();

            string symbols = "1234567890QWERTYUIOPASDFGHJKLZXCVBNM";
            char[] chars = new char[10];
            for (int i = 0; i < chars.Length; i++)
            {
                chars[i] = symbols[rand.Next(symbols.Length)];
            }
            return new String(chars);
        }

        public static bool InsertKey(string key, decimal money)
        {
            return (new Sql_Provider()).InsertKey(new ReplenishData(key, money));
        }

        public static decimal GetMoneyByKey(string key)
        {
            return (new Sql_Provider()).GetMoneyByKey(key);
        }

        public static List<string> GetKeys()
        {
            return (new Sql_Provider()).GetKeys();
        }
    }
}