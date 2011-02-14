<%@ Page Language="C#" MasterPageFile="~/Gallery.master" AutoEventWireup="true"
  CodeFile="Product.aspx.cs" Inherits="Product" Title="Gallery: Product Details Page" %>

<%@ Register src="UserControls/UserControls/ProductRecommendations.ascx" tagname="ProductRecommendations" tagprefix="uc1" %>

<%@ Register src="UserControls/ProductReviews.ascx" tagname="ProductReviews" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
    <asp:Label CssClass="CatalogTitle" ID="titleLabel" runat="server" Text="Етикет"></asp:Label>
  </p>
  <p>
    <asp:Image ID="productImage" runat="server" />
  </p>
  <p>
  <b>Описание:</b>
    <asp:Label CssClass="ProductDescription" ID="descriptionLabel" runat="server" Text="Етикет"></asp:Label>
  </p>
  <p>
  <b>Техника:</b>
    <asp:Label ID="techniqueLabel" runat="server"></asp:Label>
  </p>
  <p>
    <b>Цена:</b>
    <asp:Label CssClass="ProductPrice" ID="priceLabel" runat="server" Text="Етикет"></asp:Label>
  </p>
  <p>
    <asp:PlaceHolder ID="attrPlaceHolder" runat="server"></asp:PlaceHolder>
  </p> 
      <p>
    <asp:LinkButton ID="AddToCartButton" runat="server"
    onclick="AddToCartButton_Click">Добави в количката</asp:LinkButton>
    </p> 
    <uc1:ProductRecommendations ID="recommendations" runat="server" />
    <uc2:ProductReviews ID="ProductReviews1" runat="server" />
</asp:Content>
