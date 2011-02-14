<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
  protected void Page_Load(object sender, EventArgs e)
  {
    // set the 500 status code
    Response.Status = "500 Internal Server Error";
  }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Електронен магазин за картини: Уупс!</title>
</head>
<body>
  <form id="form1" runat="server">
    <asp:HyperLink ID="HeaderLink" ImageUrl="~/Images/GalleryLogo.png" NavigateUrl="~/" ToolTip="Gallery logo" Text="Gallery logo" runat="server" />    
    <p>Вашата заявка предизвика грешка!</p>
    <p>Извинете за неудобството. Изпратено е съобщение за грешката. Благодарим Ви!</p>
    <p>Екипът</p>
  </form>
</body>
</html>
