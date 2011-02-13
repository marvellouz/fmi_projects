<%@ Page Language="C#" MasterPageFile="~/BalloonShop.master" Title="Електронен магазин за картини: Какво търсите?" %>
<script runat="server">
protected void Page_Load(object sender, EventArgs e)
    {
        // set the 404 status code
        Response.StatusCode = 404;
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Търсите картини?</h1>
<p>
За съжаление страницата, която търсите не съществува в нашия уебсайт!
</p>
<p>Посетете нания
<asp:HyperLink ID="HyperLink1" runat="server" Target="~/" Text="каталог" />,
.
</p>
<p>Екипът</p>
</asp:Content>