using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COMP214_Project
{
    public partial class AddBooks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !(bookLent.Checked == true && friendLent.Text == "");
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //args.IsValid = !(bookList.SelectedValue == "-1" && newGenre.Text == "");
        }

        protected void bookSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //if (newGenre.Text != "")
                //{
                //    if (CheckNewGenre() == -1)
                //    {
                //        AddNewGenre();
                //        newlyCreatedGenre = CheckNewGenre();
                //    }
                //    else
                //    {
                //        bookList.SelectedValue = CheckNewGenre().ToString();
                //    }
                //}
                //AddNewBook();
                //Response.Redirect("Success.aspx");
            }

        }
    }
}