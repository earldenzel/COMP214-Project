using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using Oracle.ManagedDataAccess.Client;

namespace COMP214_Project
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["oracle1"].ConnectionString;
            using (var conn = new OracleConnection(connectionString))
            {
                var cmd = conn.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT * FROM project_books";
                conn.Open();
                var reader = cmd.ExecuteReader();
                while (reader.Read()) LabelResult.Text += "<h4>" + reader["title"] + "</h4>";

            }
        }
    }
}