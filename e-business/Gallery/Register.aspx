<%@ Page Title="" Language="C#" MasterPageFile="~/Gallery.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:LoginView ID="LoginView1" runat="server">
    <LoggedInTemplate>
      Вие вече сте регистриран.
    </LoggedInTemplate>
  </asp:LoginView>
  <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#F7F6F3" 
    BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="1px" 
    CancelDestinationPageUrl="~/" ContinueDestinationPageUrl="CustomerDetails.aspx" 
    CreateUserButtonText="Sign Up" Font-Names="Verdana" Font-Size="0.8em" 
    oncreateduser="CreateUserWizard1_CreatedUser" ActiveStepIndex="1">
    <SideBarStyle BackColor="#5D7B9D" BorderWidth="0px" Font-Size="0.9em" 
      VerticalAlign="Top" />
    <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
    <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
      BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
      ForeColor="#284775" />
    <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
      BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
      ForeColor="#284775" />
    <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" 
      Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
    <CreateUserButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
      BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
      ForeColor="#284775" />
    <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <StepStyle BorderWidth="0px" />
    <WizardSteps>
      <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" 
            Title = "Регистрация">
          <ContentTemplate>
              <table style="font-family:Verdana;font-size:100%;">
                  <tr>
                      <td align="center" colspan="2" 
                          style="color:White;background-color:#5D7B9D;font-weight:bold;">
                          Регистрация</td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                              ControlToValidate="UserName" ErrorMessage="User Name is required." 
                              ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                              ControlToValidate="Password" ErrorMessage="Password is required." 
                              ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                              AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                              ControlToValidate="ConfirmPassword" 
                              ErrorMessage="Confirm Password is required." 
                              ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                              ControlToValidate="Email" ErrorMessage="E-mail is required." 
                              ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" 
                              ControlToValidate="Question" ErrorMessage="Security question is required." 
                              ToolTip="Security question is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label>
                      </td>
                      <td>
                          <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                              ControlToValidate="Answer" ErrorMessage="Security answer is required." 
                              ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="center" colspan="2">
                          <asp:CompareValidator ID="PasswordCompare" runat="server" 
                              ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                              Display="Dynamic" 
                              ErrorMessage="The Password and Confirmation Password must match." 
                              ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                      </td>
                  </tr>
                  <tr>
                      <td align="center" colspan="2" style="color:Red;">
                          <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                      </td>
                  </tr>
              </table>
          </ContentTemplate>
        </asp:CreateUserWizardStep>
      <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" >
          <ContentTemplate>
              <table style="font-family:Verdana;font-size:100%;">
                  <tr>
                      <td align="center" 
                          style="color:White;background-color:#5D7B9D;font-weight:bold;">
                          Завършване</td>
                  </tr>
                  <tr>
                      <td>
                          Успешно завършихте регистрацията си.</td>
                  </tr>
                  <tr>
                      <td align="right">
                          <asp:Button ID="ContinueButton" runat="server" BackColor="#FFFBFF" 
                              BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" 
                              CausesValidation="False" CommandName="Continue" Font-Names="Verdana" 
                              ForeColor="#284775" onclick="ContinueButton_Click" Text="Продължи" 
                              ValidationGroup="CreateUserWizard1" />
                      </td>
                  </tr>
              </table>
          </ContentTemplate>
        </asp:CompleteWizardStep>
    </WizardSteps>
  </asp:CreateUserWizard>
</asp:Content>

