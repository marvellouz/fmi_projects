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

        readonly ObservableCollection<PageViewModel> _children;
        readonly PageViewModel _parent;
        readonly Page _page;
        static readonly PageViewModel DummyChild = new PageViewModel();
        bool _isExpanded;
        bool _isSelected;

        #endregion

         public PageViewModel(Page page)
        {
             this._page = page;
             _children = new ObservableCollection<PageViewModel>();
             _children.Add(DummyChild);
        }

        // This is used to create the DummyChild instance.
        protected PageViewModel()
        {
        }

        public bool HasDummyChild
        {
            get { return this._children.Count == 1 && this._children[0] == DummyChild; }
        }

        public string Url
        {
            get { return this._page.Url; }
        }

        public string Title
        {
            get { return this._page.Title; }
        }

        public void LoadChildren()
        {
            _children.Clear();
            _page.LoadChildren();
            foreach(Page p in _page.Children) 
            {
               
                    //BackgroundWorker worker = new BackgroundWorker();

                    //worker.DoWork += delegate(object s, DoWorkEventArgs args)
                    //{
                            PageViewModel pvm = new PageViewModel(p);
                            _children.Add(pvm);
                    //};
                    //worker.RunWorkerCompleted += delegate(object s, RunWorkerCompletedEventArgs args)
                    //{
                    //    object result = args.Result;
                    //};
                    //worker.RunWorkerAsync();

            }
        }

        #region Properties
        public ObservableCollection<PageViewModel> Children
        {
            get
            {
                if (HasDummyChild)
                {
                    LoadChildren();
                }
                return _children;
            }
        }

        public string Content { get { return _page.Content; } }

        public List<string> CssHrefs { get { return _page.CssHrefs; } }

        public List<string> JsHrefs { get { return _page.JsHrefs; } }

        public List<string> Hrefs { get { return _page.Hrefs; } }

        #endregion

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            if (this.PropertyChanged != null)
                this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }

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
    }
}
