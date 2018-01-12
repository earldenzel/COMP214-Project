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
    public partial class AddBooks : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !(bookGenre.SelectedValue == "0" && newGenre.Text == "");
        }

        protected void bookSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                AddNewBook();
                Response.Redirect("Success.aspx");
                //if (newGenre.Text != "")
                //{
                //    if (CheckNewGenre() == -1)
                //    {
                //        AddNewGenre();
                //        newlyCreatedGenre = CheckNewGenre();
                //    }
                //    //else
                //    //{
                //    //    bookGenre.SelectedValue = CheckNewGenre().ToString();
                //    //}
                //}
                ////AddNewBook();
                ////Response.Redirect("Success.aspx");
            }

        }
        
        private void AddNewBook()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["oracle1"].ConnectionString;
            OracleConnection conn = new OracleConnection();
            conn.ConnectionString = connectionString;
            OracleCommand comm = conn.CreateCommand();
            comm.CommandText = "add_new_book";
            comm.CommandType = CommandType.StoredProcedure;
            OracleParameter param1 = comm.Parameters.Add("p_isbn", OracleDbType.NVarchar2, ParameterDirection.Input);
            param1.Value = bookISBN.Text;
            OracleParameter param2 = comm.Parameters.Add("p_title", OracleDbType.NVarchar2, ParameterDirection.Input);
            param2.Value = bookTitle.Text;
            OracleParameter param3 = comm.Parameters.Add("p_pagecount", OracleDbType.Int32, ParameterDirection.Input);
            param3.Value = Convert.ToInt32(bookPageNum.Text);
            OracleParameter param4 = comm.Parameters.Add("p_userid", OracleDbType.Int32, ParameterDirection.Input);
            param4.Value = Convert.ToInt32(DropDownList1.SelectedValue);
            OracleParameter param5 = comm.Parameters.Add("p_friendname", OracleDbType.NVarchar2, ParameterDirection.Input);
            if (DropDownList2.SelectedIndex == 0)
            {
                param5.Value = friendLent.Text;
            }
            else
            {
                param5.Value = DropDownList2.SelectedValue;
            }
            OracleParameter param6 = comm.Parameters.Add("p_authorname", OracleDbType.NVarchar2, ParameterDirection.Input);
            param6.Value = bookAuthor.Text;
            OracleParameter param7 = comm.Parameters.Add("p_genrename", OracleDbType.NVarchar2, ParameterDirection.Input);
            if (bookGenre.SelectedIndex == 0)
            {
                param7.Value = newGenre.Text;
            }
            else
            {
                param7.Value = bookGenre.SelectedValue;
            }
            OracleParameter param8 = comm.Parameters.Add("p_comments", OracleDbType.NVarchar2, ParameterDirection.Input);
            param8.Value = bookNotes.Text;
            //string message = param1.Value + param2.Value + param3.Value + param4.Value 
            
            try
            {
                comm.Connection.Open();
                comm.ExecuteNonQuery();
                // Close the reader 
                // reader.Close();
            }
            catch(OracleException e)
            {
                bookOwner.Text = e.Message;
            }
            finally
            {
                comm.Connection.Close();
            }
        }
    }
}