<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserInfo.ascx.cs" Inherits="UserControls_UserInfo" %>
<table cellspacing="0" border="0" width="200px" >
  <asp:LoginView ID="LoginView1" runat="server">
      <AnonymousTemplate>
          <tr>
              <td class="UserInfoHead">
                  Добре дошли!
              </td>
          </tr>
          <tr>
              <td class="UserInfoContent">
                  Вие не сте влезли в системата.
                  <br />
                  <asp:LoginStatus ID="LoginStatus1" runat="server" LoginText="Вход"/>
                  или
                  <asp:HyperLink runat="server" ID="registerLink" NavigateUrl="~/Register.aspx" Text="Регистрация"
                      ToolTip="Към регистрация" />
              </td>
          </tr>
      </AnonymousTemplate>
    <RoleGroups>
      <asp:RoleGroup Roles="Administrators">      
        <ContentTemplate>
          <tr>
            <td class="UserInfoHead">
              <asp:LoginName ID="LoginName2" runat="server" FormatString="Здравейте, <b>{0}</b>!" />
            </td>
          </tr>            
          <tr>
            <td class="UserInfoContent">              
              <asp:LoginStatus ID="LoginStatus2" runat="server" />
              <br />
              <a href="home">Електронен магазин за картини</a>   
              <br />
              <a href="catalog-admin">Каталог (администратор)</a>
              <br />
              <a href="cart-admin">Количка (администратор)</a>
              <br />
              <a href="orders-admin">Поръчки (администратор)</a>
            </td>
          </tr>          
        </ContentTemplate>
      </asp:RoleGroup>
        <asp:RoleGroup Roles="Customers">
            <ContentTemplate>
                <tr>
                    <td class="UserInfoHead">
                        <asp:LoginName ID="LoginName2" runat="server" FormatString="Здравейте, <b>{0}</b>!" />
                    </td>
                </tr>
                <tr>
                    <td class="UserInfoContent">
                        <asp:LoginStatus ID="LoginStatus1" runat="server" />
                        <br />
                        <asp:HyperLink runat="server" ID="detailsLink" NavigateUrl="~/CustomerDetails.aspx"
                            Text="Редактиране на данните" ToolTip="Редакция на личните данни" />
                    </td>
            </ContentTemplate>
        </asp:RoleGroup>
    </RoleGroups>
  </asp:LoginView>
</table>
