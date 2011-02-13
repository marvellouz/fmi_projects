<%@ Page Title="SecurityLib Test Page 2" Language="C#" MasterPageFile="~/BalloonShop.master" AutoEventWireup="true"
  CodeFile="SecurityLibTester2.aspx.cs" Inherits="SecurityLibTester2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">  
  Въведете данни за криптиране:
  <br />
  <asp:TextBox ID="encryptBox" runat="server" />
  <br />
  Въведете данни за декриптиране:
  <br />
  <asp:TextBox ID="decryptBox" runat="server" />
  <br />
  <asp:Button ID="processButton" runat="server" Text="Давай" OnClick="processButton_Click" />
  <br />
  <asp:Label ID="result" runat="server" />
</asp:Content>
