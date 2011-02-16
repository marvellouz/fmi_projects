using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Collections.ObjectModel;
using WebCrowler.Model;

namespace WebCrowler.ViewModel
{
    class PageViewModel : INotifyPropertyChanged
    {
        #region Data

        readonly ReadOnlyCollection<PageViewModel> _children;
        readonly PageViewModel _parent;
        readonly Page _page;

        bool _isExpanded;
        bool _isSelected;

        #endregion

         public PageViewModel(Page page)
            : this(page, null)
        {
        }

        private PageViewModel(Page page, PageViewModel parent)
        {
            _page = page;
            _parent = parent;

            _children = new ReadOnlyCollection<PageViewModel>(
                    (from child in _page.Children
                     select new PageViewModel(child, this))
                     .ToList<PageViewModel>());
        }

        #region Properties

        public ReadOnlyCollection<PageViewModel> Children { get { return _children; } }

        public string Url { get { return _page.Url; } }

        public string Content { get { return _page.Content; } }

        public List<string> CssHrefs { get { return _page.CssHrefs; } }

        public List<string> JsHrefs { get { return _page.JsHrefs; } }

        public List<string> Hrefs { get { return _page.Hrefs; } }

        #endregion

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
            }
        }

        public bool IsSelected
        {
            get { return _isSelected; }
            set
            {
                if (value != _isSelected)
                {
                    _isSelected = value;
                    this.OnPropertyChanged("IsSelected");
                }
            }
        }

        public PageViewModel Parent
        {
            get { return _parent; }
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            if (this.PropertyChanged != null)
                this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

        #endregion

    }
}
