using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Windows.Input;
using WebCrowler.Model;
using System.Text.RegularExpressions;
using System.Windows;

namespace WebCrowler.ViewModel
{
    class PageTreeViewModel
    {
        #region Data

        readonly ReadOnlyCollection<PageViewModel> _firstGeneration;
        readonly PageViewModel _rootPage;
        readonly ICommand _findPagesCommand;

        IEnumerator<PageViewModel> _resultsEnumerator;
        
        string _startUrl = String.Empty;

        #endregion

        public PageTreeViewModel(Page rootPage)
        {
            _rootPage = new PageViewModel(rootPage);

            _firstGeneration = new ReadOnlyCollection<PageViewModel>(
                new PageViewModel[] { _rootPage });

            //_findPagesCommand = new FindPagesTreeCommand(this);
        }

        public string StartUrl
        {
            get { return _startUrl; }
            set
            {
                if (value == _startUrl)
                    return;

                _startUrl = value;

                _resultsEnumerator = null;
            }
        }

        public void CrawlPage()
        {
            if(! isValidUrl(this._startUrl))
            {
                MessageBox.Show(
                "Невалиден url.",
                "Опитайте отново.",
                MessageBoxButton.OK,
                MessageBoxImage.Information
                );
            }
        }

        public static bool isValidUrl(string url)
        {
            string pattern = @"^(http|https)\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+&amp;%\$#\=~])*[^\.\,\)\(\s]$";
            Regex reg = new Regex(pattern, RegexOptions.Compiled | RegexOptions.IgnoreCase);
            return reg.IsMatch(url);
        }

    }
}
