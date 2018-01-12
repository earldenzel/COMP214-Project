<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddBooks.aspx.cs" Inherits="COMP214_Project.AddBooks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Add Books</h2>
    <p>
        <asp:Label ID="bookOwner" runat="server" Text="Owned by: " Width="150" />
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="FNAME" DataValueField="USERID"></asp:DropDownList>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" 
            ConnectionString='<%$ ConnectionStrings:oracle1 %>' 
            ProviderName='<%$ ConnectionStrings:oracle1.ProviderName %>' 
            SelectCommand='SELECT "USERID", "FNAME" FROM "PROJECT_USER" WHERE "USERID" <> 0'></asp:SqlDataSource>
    </p>
    <p>
        <asp:Label ID="bookTitleLabel" runat="server" Text="Book Title: " Width="150" />
        <asp:TextBox ID="bookTitle" runat="server" Text="" Width="200" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
            ErrorMessage="Title of the book is required"
            ControlToValidate="bookTitle"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="bookAuthorLabel" runat="server" Text="Book Author/s: " Width="150" />
        <asp:TextBox ID="bookAuthor" runat="server" Text="" Width="200" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
            ErrorMessage="Author of the book is required"
            ControlToValidate="bookAuthor"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="bookISBNLabel" runat="server" Text="ISBN: " Width="150" />
        <asp:TextBox ID="bookISBN" runat="server" Text="" Width="200" />
    </p>
    <p>
        <asp:Label ID="bookGenreLabel" runat="server" Text="Genre: " Width="150" />
        <asp:DropDownList ID="bookGenre" runat="server" DataSourceID="SqlDataSource2" DataTextField="GENRENAME" DataValueField="GENRENAME"></asp:DropDownList>     
        <asp:Label ID="specifyLabel" runat="server" Text=" or type new genre: " />
        <asp:TextBox ID="newGenre" runat="server" Text="" Width="200" ></asp:TextBox>
        <asp:CustomValidator ID="CustomValidator2" runat="server"
            OnServerValidate="CustomValidator2_ServerValidate" 
            ErrorMessage="Please provide genre!">            
        </asp:CustomValidator>
        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:oracle1 %>' ProviderName='<%$ ConnectionStrings:oracle1.ProviderName %>' SelectCommand="SELECT &quot;GENRENAME&quot; FROM &quot;PROJECT_GENRE&quot; ORDER BY &quot;GENREID&quot;"></asp:SqlDataSource>
    </p>
    <p>
        <asp:Label ID="friendLentLabel" runat="server" Text="Lent to friend: " Width="150" /> 
        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3" DataTextField="FRIENDNAME" DataValueField="FRIENDNAME"></asp:DropDownList>
        <asp:Label ID="Label1" runat="server" Text=" or type new friend: " /> 
        <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:oracle1 %>' ProviderName='<%$ ConnectionStrings:oracle1.ProviderName %>' SelectCommand='SELECT "FRIENDID", "FRIENDNAME" FROM "PROJECT_FRIEND" ORDER BY "FRIENDID"'></asp:SqlDataSource>
        <asp:TextBox ID="friendLent" runat="server" Text="" Width="200" ></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="bookPageNumLabel" runat="server" Text="Number of Pages: " Width="150" />
        <asp:TextBox ID="bookPageNum" runat="server" Text="" Width="200" ></asp:TextBox>
        <asp:CompareValidator ID="CompareValidator1" runat="server"
            ControlToValidate="bookPageNum"
            Operator="GreaterThan" Type="Integer" ValueToCompare="0"
            Display="Dynamic"
            ErrorMessage="Page number must be a number greater than 0.">
        </asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
            ControlToValidate="bookPageNum" 
            Display="Dynamic"
            ErrorMessage="The number of pages is required!"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="bookNotesLabel" runat="server" Text="Comments: " Width="150" />
        <asp:TextBox ID="bookNotes" runat="server" Rows="5" TextMode="MultiLine"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="bookSave" runat="server" Text="Save" OnClick="bookSave_Click" />
        <asp:Button ID="clearForm" runat="server" Text="Cancel and Clear" />
    </p>
</asp:Content>
