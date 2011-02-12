using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using WebCrowler.Model;

namespace WebCrowler.ViewModel
{
    class CrawlerViewModel
    {
        #region Private Fields

        private static List<Page> _pages = new List<Page>();

        #endregion
        private string url;
        public string Url
        {
            get
            {
                return this.url;
            }
            set
            {
                this.url = value;
                this.CrawlPage();
            }
        }
        
        public void CrawlPage()
        {
            if (!PageHasBeenCrawled(this.url))
            {
                LinksParser parser = new LinksParser();
                Page page = new Page();
                page.Url = this.url;
                page.Content = GetPageContent(this.url);
                parser.Parse(page);
                page.Hrefs = (List<string>)parser.GoodUrls.Select(element => ResolveRelativeUrl(this.url, element));
                page.CssHrefs = (List<string>)parser.cssUrls.Select(element => ResolveRelativeUrl(this.url, element));
                page.JsHrefs = (List<string>)parser.jsUrls.Select(element => ResolveRelativeUrl(this.url, element));

                _pages.Add(page);
            }
        }

        private static bool PageHasBeenCrawled(string url)
        {
            foreach (Page page in _pages)
            {
                if (page.Url == url)
                    return true;
            }

            return false;
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

        public static void SavePageContent(string page_content, string file_path, string file_name)
        {
            File.WriteAllText((file_path + file_name), page_content, Encoding.UTF8);
        }

        public void SaveFile(string url, string save_path, string file_name)
        {
            WebClient wc = new WebClient();
            wc.DownloadFile(url, (save_path + file_name));
        }
    }
}
