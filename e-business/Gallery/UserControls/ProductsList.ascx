<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductsList.ascx.cs" Inherits="UserControls_ProductsList" %>
<%@ Register src="Pager.ascx" tagname="Pager" tagprefix="uc1" %>
<uc1:Pager ID="topPager" runat="server" Visible="False" />
<asp:DataList ID="list" runat="server" RepeatColumns="2" CssClass="ProductList" 
    onitemdatabound="list_ItemDataBound" EnableViewState="False">
  <ItemTemplate>
    <h3 class="ProductTitle">
      <a href="<%# Link.ToProduct(Eval("ProductID").ToString()) %>">
        <%# HttpUtility.HtmlEncode(Eval("Name").ToString()) %>
      </a>
    </h3>
    <a href="<%# Link.ToProduct(Eval("ProductID").ToString()) %>">
      <img width="100" border="0" 
src="<%# Link.ToProductImage(Eval("Thumbnail").ToString()) %>" 
alt='<%# HttpUtility.HtmlEncode(Eval("Name").ToString())%>' />
    </a>
    <p class="ProductDescription">
    <%# HttpUtility.HtmlEncode(Eval("Description").ToString()) %>
    </p>
        <p class="Technique">
        <b>Техника: </b>
    <%# HttpUtility.HtmlEncode(Eval("Technique").ToString()) %>
    </p>
   <p class="DetailSection">
Цена:
<%# Eval("Price", "{0:c}") %>
</p>
<asp:PlaceHolder ID="attrPlaceHolder" runat="server"></asp:PlaceHolder>
  </ItemTemplate>
</asp:DataList>
<uc1:Pager ID="bottomPager" runat="server" Visible="False" />

