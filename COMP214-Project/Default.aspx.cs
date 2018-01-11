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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string connectionString = WebConfigurationManager.ConnectionStrings["oracle1"].ConnectionString;
            //using (var conn = new OracleConnection(connectionString))
            //{
            //    var cmd = conn.CreateCommand();
            //    cmd.CommandType = CommandType.Text;
            //    cmd.CommandText = "SELECT * FROM project_books";
            //    conn.Open();
            //    var reader = cmd.ExecuteReader();
            //    while (reader.Read()) LabelResult.Text += "<h4>" + reader["title"] + "</h4>";

            //}
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["oracle1"].ConnectionString;
            OracleConnection conn = new OracleConnection();
            conn.ConnectionString = connectionString;
            OracleCommand comm = conn.CreateCommand();
            comm.CommandText = "common_book_info";
            comm.CommandType = CommandType.StoredProcedure;
            OracleParameter param1 = comm.Parameters.Add("p_search", OracleDbType.NVarchar2, ParameterDirection.Input);
            param1.Value = TextBox1.Text;
            OracleParameter param = comm.Parameters.Add("ref_cur", OracleDbType.RefCursor, ParameterDirection.Output);
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