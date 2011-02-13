<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="AdminCategories.aspx.cs" Inherits="AdminCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titlePlaceHolder" runat="Server">
  <span class="AdminTitle">
    Електронен магазин за картини (аднинистраторска част)
    <br />
    Категории в
    <asp:HyperLink ID="deptLink" runat="server" />
  </span>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="adminPlaceHolder" Runat="Server">
  <p>
    <asp:Label ID="statusLabel" runat="server" Text=""></asp:Label>
  </p>
  <asp:GridView ID="grid" runat="server" DataKeyNames="CategoryID" 
    AutoGenerateColumns="False" Width="100%" 
    onrowcancelingedit="grid_RowCancelingEdit" onrowdeleting="grid_RowDeleting" 
    onrowediting="grid_RowEditing" onrowupdating="grid_RowUpdating">
    <Columns>
      <asp:BoundField DataField="Name" HeaderText="Име на категорията" SortExpression="Name" />
      <asp:TemplateField HeaderText="Описание на категорията" SortExpression="Description">
        <ItemTemplate>
          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'>
          </asp:Label>
        </ItemTemplate>
        <EditItemTemplate>
          <asp:TextBox ID="descriptionTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>' Height="70px" Width="400px" />
        </EditItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField>
        <ItemTemplate>
          <asp:HyperLink runat="server" ID="link" NavigateUrl='<%# "AdminProducts.aspx?DepartmentID=" + Request.QueryString["DepartmentID"] + "&amp;CategoryID=" + Eval("CategoryID")%>' Text="Виж продуктите">
          </asp:HyperLink>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:CommandField ShowEditButton="True" />
      <asp:ButtonField CommandName="Delete" Text="Изтрий" />
    </Columns>
  </asp:GridView>
  <p>Създаване на нова категория:</p>
  <p>Име:</p>
  <asp:TextBox ID="newName" runat="server" Width="400px" />
  <p>Описание:</p>
  <asp:TextBox ID="newDescription" runat="server" Width="400px" Height="70px" TextMode="MultiLine" />
  <p><asp:Button ID="createCategory" Text="Създай категория" runat="server" 
      onclick="createCategory_Click" /></p>
</asp:Content>
