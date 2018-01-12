using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using Oracle.ManagedDataAccess.Client;
using System.Configuration;

namespace COMP214_Project
{
    public partial class ViewLogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["oracle1"].ConnectionString;
            OracleConnection conn = new OracleConnection();
            conn.ConnectionString = connectionString;
            OracleCommand comm = conn.CreateCommand();
            comm.CommandText = "log_info";
            comm.CommandType = CommandType.StoredProcedure;
            OracleParameter param1 = comm.Parameters.Add("p_search", OracleDbType.Int32, ParameterDirection.Input);
            param1.Value = Convert.ToInt32(DropDownList1.SelectedValue);
            OracleParameter param = comm.Parameters.Add("v_refcur", OracleDbType.RefCursor, ParameterDirection.Output);
            DataTable table;

            try
            {
                comm.Connection.Open();
                // Execute the command and save the results in a DataTable
                // OracleDataReader reader = comm.ExecuteReader();
                table = new DataTable();
                OracleDataAdapter ds = new OracleDataAdapter(comm);

                // table.Load(reader);
                ds.Fill(table);

                // Close the reader 
                // reader.Close();
            }
            catch
            {
                throw;
            }
            finally
            {
                comm.Connection.Close();
            }
            GridView1.DataSource = table;
            GridView1.DataBind();
        }
    }
}