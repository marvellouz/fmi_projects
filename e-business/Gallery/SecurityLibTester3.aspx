<%@ Page Title="SecurityLib Test Page 3" Language="C#" MasterPageFile="~/Gallery.master"
  AutoEventWireup="true" CodeFile="SecurityLibTester3.aspx.cs" Inherits="SecurityLibTester3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  Картодържател:<br />
  <asp:TextBox ID="cardHolderBox" runat="server" />
  <br />
  Нимер на картата:<br />
  <asp:TextBox ID="cardNumberBox" runat="server" />
  <br />
  Дата на издаване:<br />
  <asp:TextBox ID="issueDateBox" runat="server" />
  <br />
  Валидна до:<br />
  <asp:TextBox ID="expiryDateBox" runat="server" />
  <br />
  Входящ номер:<br />
  <asp:TextBox ID="issueNumberBox" runat="server" />
  <br />
  Тип на картата:<br />
  <asp:TextBox ID="cardTypeBox" runat="server" />
  <br />
  <asp:Button ID="processButton" runat="server" Text="Давай" OnClick="processButton_Click" />
  <br />
  <asp:Label ID="result" runat="server" />
</asp:Content>
