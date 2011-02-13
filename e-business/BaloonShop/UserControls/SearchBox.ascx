<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SearchBox.ascx.cs" Inherits="UserControls_SearchBox" %>
<asp:Panel ID="searchPanel" runat="server" DefaultButton="goButton">
<table class="SearchBox">
<tr>
<td class="SearchBoxHead">Търсене</td>
</tr>
<tr>
<td class="SearchBoxContent">
<asp:TextBox ID="searchTextBox" Runat="server" Width="110px"
MaxLength="100" />
<asp:Button ID="goButton" Runat="server"
Text="Давай" Width="55px" onclick="goButton_Click" /><br />
<asp:CheckBox ID="allWordsCheckBox" Runat="server"
Text="Търсене за всички думи" />
</td>
</tr>
</table>
</asp:Panel>
