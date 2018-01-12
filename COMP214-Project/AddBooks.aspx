<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AddBooks.aspx.cs" Inherits="COMP214_Project.AddBooks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Add Books</h2>

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
        <asp:DropDownList ID="bookGenre" runat="server"></asp:DropDownList>
        <asp:CustomValidator ID="CustomValidator2" runat="server"
            OnServerValidate="CustomValidator2_ServerValidate" 
            ErrorMessage="Please provide genre if not available in the list!">            
        </asp:CustomValidator>
    </p>
    <p>        
        <asp:Label ID="specifyLabel" runat="server" Text="Please specify: " Width="150" />
        <asp:TextBox ID="newGenre" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="bookLentLabel" runat="server" Text="Lent to a friend? " Width="150" /> 
        <asp:CheckBox ID="bookLent" runat="server" />  
    </p>
    <p>
        <asp:Label ID="friendLentLabel" runat="server" Text="Name of friend: " Width="150" />
        <asp:TextBox ID="friendLent" runat="server"></asp:TextBox>
        <asp:CustomValidator ID="CustomValidator1" runat="server"
            OnServerValidate="CustomValidator1_ServerValidate" 
            ErrorMessage="Name of friend who borrowed must be provided, if book is lent!">
        </asp:CustomValidator>
    </p>
    <p>
        <asp:Label ID="bookPageNumLabel" runat="server" Text="Number of Pages: " Width="150" />
        <asp:TextBox ID="bookPageNum" runat="server"></asp:TextBox>
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
