<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true"
  CodeFile="AdminOrders.aspx.cs" Inherits="AdminOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titlePlaceHolder" runat="Server">
  <span class="AdminTitle">Електронен магазин за картини (аднинистраторска част)
    <br />
    Поръчки </span>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="adminPlaceHolder" runat="Server">
Покажи последните
  <asp:TextBox ID="recentCountTextBox" runat="server" MaxLength="4" Width="40px" Text="20" />
  записи
  <asp:Button ID="byRecentGo" runat="server" Text="Напред" CausesValidation="False" 
    onclick="byRecentGo_Click" /><br />
  Покажи всички записи, направени между
  <asp:TextBox ID="startDateTextBox" runat="server" Width="72px" />
  и
  <asp:TextBox ID="endDateTextBox" runat="server" Width="72px" />
  <asp:Button ID="byDateGo" runat="server" Text="Напред" onclick="byDateGo_Click" />
  <br />
  Покажи всички неприети и неотменени поръчки
  <asp:Button ID="unverfiedGo" runat="server" Text="Давай" CausesValidation="False"
    onclick="unverfiedGo_Click" />
  <br />
  Покажи всички приети, неприключени поръчки
  <asp:Button ID="uncompletedGo" runat="server" Text="Давай" CausesValidation="False"
    onclick="uncompletedGo_Click" />
  <br />
  <br />
  <asp:Label ID="errorLabel" runat="server" CssClass="AdminError" 
    EnableViewState="False"></asp:Label>
&nbsp;<asp:RangeValidator ID="startDateValidator" runat="server" 
    ControlToValidate="startDateTextBox" Display="None" 
    ErrorMessage="Невалидна начална дата" MaximumValue="1/1/2015" 
    MinimumValue="1/1/2009" Type="Date"></asp:RangeValidator>
&nbsp;<asp:RangeValidator ID="endDateValidator" runat="server" 
    ControlToValidate="endDateTextBox" Display="None" 
    ErrorMessage="Невалидна крайна дата" MaximumValue="1/1/2015" MinimumValue="1/1/1999" 
    Type="Date"></asp:RangeValidator>
&nbsp;<asp:CompareValidator ID="compareDatesValidator" runat="server" 
    ControlToCompare="endDateTextBox" ControlToValidate="startDateTextBox" 
    Display="None" ErrorMessage="Началната дата трябва да е преди крайната дата" 
    Operator="LessThan" Type="Date"></asp:CompareValidator>
  <asp:ValidationSummary ID="validationSummary" runat="server" 
    CssClass="AdminError" HeaderText="Грешки при валидацията на данните" />
  <br />
  <asp:GridView ID="grid" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="OrderID" onselectedindexchanged="grid_SelectedIndexChanged">
    <Columns>
      <asp:BoundField DataField="OrderID" HeaderText="OrderID" ReadOnly="True" 
        SortExpression="OrderID" />
      <asp:BoundField DataField="DateCreated" HeaderText="Дата на създаване" 
        ReadOnly="True" SortExpression="DateCreated" />
      <asp:BoundField DataField="DateShipped" HeaderText="Дата на доставка" 
        ReadOnly="True" SortExpression="DateShipped" />
      <asp:CheckBoxField DataField="Verified" HeaderText="Приета" ReadOnly="True" 
        SortExpression="Verified" />
      <asp:CheckBoxField DataField="Completed" HeaderText="Завършена" ReadOnly="True" 
        SortExpression="Completed" />
      <asp:CheckBoxField DataField="Canceled" HeaderText="Отменена" ReadOnly="True" 
        SortExpression="Canceled" />
      <asp:BoundField DataField="CustomerName" HeaderText="Име на клиента" ReadOnly="True" 
        SortExpression="CustomerName" />
      <asp:ButtonField ButtonType="Button" CommandName="Select" Text="Избери" />
    </Columns>
  </asp:GridView>
</asp:Content>
