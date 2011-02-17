using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Windows.Input;
using WebCrowler.Model;
using System.Text.RegularExpressions;
using System.Windows;
using System.ComponentModel;

namespace WebCrowler.ViewModel
{
    class PageTreeItemViewModel : INotifyPropertyChanged
    {
        #region Data

        readonly ReadOnlyCollection<PageViewModel> _firstGeneration;
        readonly PageViewModel _rootPage;
        readonly ICommand _findPagesCommand;

        IEnumerator<PageViewModel> _resultsEnumerator;
        
        string _startUrl = String.Empty;

        #endregion

        #region Data

        static readonly PageTreeItemViewModel DummyChild = new PageTreeItemViewModel();





        #endregion

        // This is used to create the DummyChild instance.
        protected PageTreeItemViewModel()
        {
        }

        public ObservableCollection<PageTreeItemViewModel> Children
        {
            get { return _children; }
        }

        // Returns true if this object's Children have not yet been populated.
        public bool HasDummyChild
        {
            get { return this.Children.Count == 1 && this.Children[0] == DummyChild; }
        }

        // Gets/sets whether the TreeViewItem 
        // associated with this object is expanded.
        public bool IsExpanded
        {
            get { return _isExpanded; }
            set
            {
                if (value != _isExpanded)
                {
                    _isExpanded = value;
                    this.OnPropertyChanged("IsExpanded");
                }

                // Expand all the way up to the root.
                if (_isExpanded && _parent != null)
                    _parent.IsExpanded = true;

                // Lazy load the child items, if necessary.
                if (this.HasDummyChild)
                {
                    this.Children.Remove(DummyChild);
                    this.LoadChildren();
                }
            }
        }

        // Invoked when the child items need to be loaded on demand.
        // Subclasses can override this to populate the Children collection.
        protected virtual void LoadChildren()
        {
        }

        public PageTreeItemViewModel Parent
        {
            get { return _parent; }
        }
        
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            if (this.PropertyChanged != null)
                this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

        //================================================================================

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
