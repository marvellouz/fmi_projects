using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace WebCrowler.Model
{
    class Crawler
    {
        #region Private Fields

        private static List<Page> _pages = new List<Page>();
        private static List<string> _externalUrls = new List<string>();
        private static List<string> _otherUrls = new List<string>();
        private static List<string> _failedUrls = new List<string>();
        private static List<string> _exceptions = new List<string>();
        private static List<string> _classes = new List<string>();
        private static StringBuilder _logBuffer = new StringBuilder();

        #endregion

        public static void Crawl()
        {
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

    }
}
