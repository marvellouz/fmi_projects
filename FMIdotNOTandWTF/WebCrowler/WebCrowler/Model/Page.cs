using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;

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

        readonly List<Page> _children = new List<Page>();
        public IList<Page> Children
        {
            get { return _children; }
        }

        #region Constructors
        
        public Page() { }

        public Page(string url)
        {
            url = NormalizeUrl(url);
            this._url = url;
            this._content = GetPageContent(url);
            LinksParser parser = new LinksParser();
            parser.Parse(this);
            this._hrefs = f(parser.GoodUrls, this._url);
            this._css_hrefs = f(parser.cssUrls, this._url);
            this._js_hrefs = f(parser.jsUrls, this._url);
        }

        #endregion

        public void LoadChildren()
        {
            this._hrefs.ForEach(x => this._children.Add(new Page(x)));
        }

        private List<string> f(List<string> parserGoodUrls, string url)
        {
            List<string> into = new List<string>();
            foreach (var e in parserGoodUrls)
            {
                try
                {
                    into.Add(ResolveRelativeUrl(url, e));
                }
                catch (UriFormatException)
                {
                    continue;
                }

            }
            return into;

        }

        public static string NormalizeUrl (string url)
        {
            if ((url.StartsWith("http://")) || url.StartsWith("https://"))
            {
                return url;
            }
            else
            {
                return "http://" + url;
            }
        }
        
        public static string ResolveRelativeUrl(string currentUrl, string url)
        {
            Uri currentUri = new Uri(currentUrl);
            Uri relativeUri = new Uri(url);

            if (!relativeUri.IsAbsoluteUri)
            {
                Uri resolved = new Uri(currentUri, url);
                return resolved.AbsoluteUri;
            }
            else
            {
                return url;
            }

        }

        public static string GetPageContent(string url)
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
            WebResponse response = request.GetResponse();
            Stream stream = response.GetResponseStream();
            StreamReader reader = new StreamReader(stream);
            string page_content = reader.ReadToEnd();

            return page_content;
        }

        public string Content
        {
            get { return _content; }
            set { _content = value; }
        }

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
