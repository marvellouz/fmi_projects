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
        private List<string> _css_hrefs;
        private List<string> _js_hrefs;
        private List<string> _hrefs;
        
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

        public List<string> CssHrefs
        {
            get { return _css_hrefs; }
            set { _css_hrefs = value; }
        }

        public List<string> JsHrefs
        {
            get { return _js_hrefs; }
            set { _js_hrefs = value; }
        }

        public List<string> Hrefs
        {
            get { return _hrefs; }
            set { _hrefs = value; }
        }
    }
}
