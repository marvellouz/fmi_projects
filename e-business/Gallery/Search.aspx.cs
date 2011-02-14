using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // don't reload data during postbacks
        if (!IsPostBack)
        {
            // fill the table contents
            string searchString = Request.QueryString["Search"];
            titleLabel.Text = "Product Search";
            descriptionLabel.Text = "You searched for \"" + searchString + "\"";
            // set the title of the page
            this.Title = GalleryConfiguration.SiteName +
            " : Product Search : " + searchString;
        }
    }
}
