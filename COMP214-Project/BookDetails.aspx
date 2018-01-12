<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="COMP214_Project.BookDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Book Details</h2>
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="720px" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>

        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True"></CommandRowStyle>

        <EditRowStyle BackColor="#2461BF"></EditRowStyle>

        <FieldHeaderStyle Width="20%" BackColor="#DEE8F5" Font-Bold="True"></FieldHeaderStyle>

        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></FooterStyle>

        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White"></PagerStyle>

        <RowStyle BackColor="#EFF3FB"></RowStyle>
    </asp:DetailsView>
</asp:Content>
