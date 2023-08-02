using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace nocutAR.Common
{
    public class DBManager
    {
        public DBManager()
        {

        }
        string GetConnectionString()
        {
            String connectionString =
                   ConfigurationManager.ConnectionStrings["nocutAR_connectionString"].ConnectionString;
            return connectionString;
        }

        public DataSet RunSelectQuery(SqlCommand sqlQuery)
        {
            SqlConnection DBConnection = new SqlConnection(GetConnectionString());

            SqlDataAdapter dbAdapter = new SqlDataAdapter();

            dbAdapter.SelectCommand = sqlQuery;

            sqlQuery.Connection = DBConnection;

            DataSet resultsDataSet = new DataSet();

            //try
            {
                dbAdapter.Fill(resultsDataSet);
            }
            //catch(Exception)
            {
            }
            return resultsDataSet;
        }

        public int RunQuery(SqlCommand sqlQuery)
        {
            SqlConnection DBConnection = new SqlConnection(GetConnectionString());

            sqlQuery.Connection = DBConnection;
            int nRet = -1;

            try
            {
                DBConnection.Open();
                nRet = sqlQuery.ExecuteNonQuery();
            }
            finally
            {
                if (DBConnection.State == ConnectionState.Open)
                {
                    DBConnection.Close();
                }
            }
            return nRet;
        }

        public static bool IsNullOrEmpty(DataSet ds)
        {
            if (ds == null || ds.Tables.Count < 1 || ds.Tables[0].Rows.Count < 1)
                return true;

            return false;
        }
    }

}