<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true"
  CodeFile="OrderTest.aspx.cs" Inherits="OrderTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titlePlaceHolder" runat="Server">
  <span class="AdminTitle">Електронен магазин за картини - теставане на поръчка</span>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="adminPlaceHolder" runat="Server">
  Номер на поръчка:
  <asp:TextBox runat="server" ID="orderIDBox" />
  <br />
  <asp:Button runat="server" ID="goButton" Text="Go" onclick="goButton_Click" />
  <br />
  <br />
  <asp:Label runat="server" ID="resultLabel" />
  <br />
  <br />
  <strong>Адрес на клиента:</strong>
  <br />
  <asp:Label runat="server" ID="addressLabel" />
  <br />
  <br />
  <strong>Кредитна карта на клиента:</strong>
  <br />
  <asp:Label runat="server" ID="creditCardLabel" />
  <br />
  <br />
  <strong>Данни за поръчката:</strong>
  <br />
  <asp:Label runat="server" ID="orderLabel" />
</asp:Content>
