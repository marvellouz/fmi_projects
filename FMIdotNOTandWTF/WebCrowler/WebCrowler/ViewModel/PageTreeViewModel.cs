using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebCrowler.Model;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace WebCrowler.ViewModel
{
    class PageTreeViewModel
    {
        PageViewModel _rootPage;
        ObservableCollection<PageViewModel> _firstLevel;
        ObservableCollection<PageViewModel> _visited;
        string _currentUrl;

        public PageTreeViewModel()
        {
            _firstLevel = new ObservableCollection<PageViewModel>();
            _visited = new ObservableCollection<PageViewModel>();
        }

        RelayCommand _crawlCommand;
        public ICommand CrawlCommand
        {
            get
            {
                if (_crawlCommand == null)
                {
                    _crawlCommand = new RelayCommand(param => this.CrawlRootPage(),
                        param => this.CanSave);
                }
                return _crawlCommand;
            }
        }

        public void CrawlRootPage()
        {
             _rootPage = new PageViewModel(new Page(CurrentUrl));
             _firstLevel.Clear();
             _rootPage.LoadChildren();
             _rootPage.Children.ToList().ForEach(x => _firstLevel.Add(x));
             _visited.Add(_rootPage);
        }

        public bool CanSave { get { return CurrentUrl != null; } }

        public string CurrentUrl 
        { 
            get { return _currentUrl; }
            set { _currentUrl = value; }
        }
        
        public ObservableCollection<PageViewModel> FirstLevel { get { return _firstLevel; } }

    }
}
