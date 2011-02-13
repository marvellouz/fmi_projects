using System;
using System.Web.UI.WebControls;
using System.Web.Security;
public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Set the title of the page
        this.Title = GalleryConfiguration.SiteName +
        " : Регистрация";
        CreateUserWizard1.UserNameLabelText = "Потребителско име: ";
        CreateUserWizard1.PasswordLabelText = "Парола: ";
        CreateUserWizard1.ConfirmPasswordLabelText = "Повторете паролата: ";
        CreateUserWizard1.QuestionLabelText = "Таен въпрос: ";
        CreateUserWizard1.AnswerLabelText = "Отговор: ";
        CreateUserWizard1.CreateUserButtonText = "Регистрация";
        CreateUserWizard1.ContinueButtonText = "Регистрация";


    }
    protected void CreateUserWizard1_CreatedUser(object sender,
    EventArgs e)
    {
        Roles.AddUserToRole((sender as CreateUserWizard).UserName,
        "Customers");
    }
}