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
        private const string _LINK_REGEX = "href\\s*=\\s*(?:\"(?<1>[^\"]*)\"|(?<1>\\S+))";// "href=\"([^>]+)\"";
        //Regex string for finding all page images in the content of a page
        private const string _IMG_REGEX = "src=\"([^>]+)\"";
        string _TITLE_REGEX = @"(?<=<title.*>)([\s\S]*)(?=</title>)";

        #region Private Fields
        private List<string> _goodUrls = new List<string>();
        private List<string> _badUrls = new List<string>();
        private List<string> _cssUrls = new List<string>();
        private List<string> _jsUrls = new List<string>();
        private List<string> _imgUrls = new List<string>();
        private string _title;
        #endregion

        #region Public Properties

        public List<string> GoodUrls
        {
            get { return _goodUrls; }
            set { _goodUrls = value; }
        }

        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        public List<string> BadUrls
        {
            get { return _badUrls; }
            set { _badUrls = value; }
        }

        public List<string> cssUrls
        {
            get { return _cssUrls; }
            set { _cssUrls = value; }
        }

        public List<string> jsUrls
        {
            get { return _jsUrls; }
            set { _jsUrls = value; }
        }

        public List<string> imgUrls
        {
            get { return _imgUrls; }
            set { _imgUrls = value; }
        }
        #endregion

        //Default constructor
        public LinksParser() { }
        
            //Parsing for different links
            public void Parse(Page page)
            {
                MatchCollection HrefMatches = Regex.Matches(page.Content, _LINK_REGEX);
                MatchCollection ImgMatches = Regex.Matches(page.Content, _LINK_REGEX);
                
                Regex ex = new Regex(_TITLE_REGEX, RegexOptions.IgnoreCase);
                Title = ex.Match(page.Content).Value.Trim();

                for (int i = 5; i <= HrefMatches.Count - 1; i++)
                {
                    if (HrefMatches[i].Value == String.Empty)
                    {
                        BadUrls.Add("Blank url value on page " + page.Url);
                        continue;
                    }

                    string href = null;

                    href = HrefMatches[i].Groups[1].Value;

                    if (IsCSS(href))
                    {
                        cssUrls.Add(href);
                    }
                    else if (IsJS(href))
                    {
                        jsUrls.Add(href);
                    }
                    else GoodUrls.Add(href);
                }
                
                for (int i = 0; i <= ImgMatches.Count - 1; i++)
                {
                    if (ImgMatches[i].Value == String.Empty)
                    {
                        BadUrls.Add("Blank img value on page " + page.Url);
                        continue;
                    }
                    
                    string src = null;
                    src = HrefMatches[i].Groups[1].Value;

                    imgUrls.Add(src);
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

        public static bool IsCSS(string href)
        {
            string extension = href.Substring(href.LastIndexOf(".") + 1, href.Length - href.LastIndexOf(".") - 1);
            return (extension == ".css");
          
        }

        public static bool IsJS(string href)
        {
            bool javascript = href.Contains("javascript:");
            string extension = href.Substring(href.LastIndexOf(".") + 1, href.Length - href.LastIndexOf(".") - 1);
            return (extension == ".js" || javascript);
        }
    }
}
