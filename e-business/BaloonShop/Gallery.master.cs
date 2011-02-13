using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
 

public partial class Gallery : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            //Correct the paths of the HeaderLink
            HeaderLink.NavigateUrl = Link.BuildAbsolute("");
            HeaderLink.ImageUrl = Link.BuildAbsolute("Images/GalleryLogo.png");
            HeaderLink.ToolTip = "Gallery logo";
        }
    }

    protected override void Render(HtmlTextWriter writer)
    {
        foreach (Control control in Page.Header.Controls)
        {
            HtmlLink link;

            //We find the automatically generated link tag for the css file and correct its path.
            link = control as HtmlLink;
            if ((link != null) && link.Href.StartsWith("~/"))
            {
                if (Request.ApplicationPath == "/")
                    link.Href = link.Href.Substring(1);
                else
                    link.Href = Request.ApplicationPath + "/" + link.Href.Substring("~/".Length);
            }
        }

        //This corrects the default action of the web form, which otherwise is set to the relative
        //path of the currently opened aspx form. This way we set it to the full path.
        this.form1.Action = Request.Url.ToString();

        base.Render(writer);
    }
}
