using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;


namespace WebCrowler.Model
{
    class LinksParser
    {
        //Regex string for finding all page links in the content of a page
        private const string _LINK_REGEX = "href=\"[a-zA-Z./:&\\d_-]+\"";

        #region Private Fields
        private List<string> _goodUrls = new List<string>();
        private List<string> _badUrls = new List<string>();
        private List<string> _otherUrls = new List<string>();
        private List<string> _externalUrls = new List<string>();
        private List<string> _exceptions = new List<string>();
        #endregion


        #region Public Properties

        public List<string> GoodUrls
        {
            get { return _goodUrls; }
            set { _goodUrls = value; }
        }

        public List<string> BadUrls
        {
            get { return _badUrls; }
            set { _badUrls = value; }
        }

        public List<string> OtherUrls
        {
            get { return _otherUrls; }
            set { _otherUrls = value; }
        }

        public List<string> ExternalUrls
        {
            get { return _externalUrls; }
            set { _externalUrls = value; }
        }

        public List<string> Exceptions
        {
            get { return _exceptions; }
            set { _exceptions = value; }
        }

        #endregion


        //Default constructor
        public LinksParser() { }
        
        //Parsing for different links
            public void Parse(Page page, string url)
            {
                MatchCollection matches = Regex.Matches(page.Content, _LINK_REGEX);
                for (int i = 0; i <= matches.Count - 1; i++)
                {
                    if (matches[i].Value == String.Empty)
                    {
                        BadUrls.Add("Blank url value on page " + url);
                        continue;
                    }

                    string href = null;
                    try
                    {
                        href = matches[i].Value.Replace("href=\"", "");
                        //the url
                        href = href.Substring(0, href.IndexOf("\""));
                        GoodUrls.Add(href);
                    }
                    catch (Exception exc)
                    {
                        Exceptions.Add("Error parsing matched href: " + exc.Message);
                    } 
                }
            }

        private static string BaseUrl(string url)
        {
            Uri uri = new Uri(url);
            string base_url = uri.GetLeftPart(UriPartial.Authority);
            return base_url;
        }

        private static string UrlScheme(string url)
        {
            Uri uri = new Uri(url);
            string url_scheme = uri.GetLeftPart(UriPartial.Scheme);
            return url_scheme;
        }


        //private static bool IsExternalUrl(string url)
        //{
        //    if ((BaseUrl(url) == (UrlScheme(url) + "localhost")) || (BaseUrl(url) == (UrlScheme(url) + "127.0.0.1")))
        //    {
        //        return false;
        //    }
        //    else if (UrlScheme(url) == "http://" || UrlScheme(url) == "https://")
        //    {
        //        return true;
        //    }

        //    return false;
        //}
    }
}
