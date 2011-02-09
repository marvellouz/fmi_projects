using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WebCrowler.Model
{
    class Page
    {
        #region Private Fields
        private string _url;
        private string _content;
        #endregion

        //Default Construgtor
        public Page() { }
        

        //Get/Set content
        public string Content
        {
            get { return _content; }
            set { _content = value; }
        }

        //Get/Set url
        public string Url
        {
            get { return _url; }
            set { _url = value; }
        }
    }
}
