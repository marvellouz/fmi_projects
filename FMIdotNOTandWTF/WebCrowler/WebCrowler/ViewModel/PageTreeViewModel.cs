using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Windows.Input;
using WebCrowler.Model;

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

    }
}
