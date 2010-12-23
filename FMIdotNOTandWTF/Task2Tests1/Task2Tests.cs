using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Task2;
using System.Threading;
using System.IO;

namespace Task2Tests
{
    [TestClass]
    public class Task2Tests
    {
        [TestMethod]
        public void CollectInfoTest()
        {
            var path = Environment.CurrentDirectory + Path.PathSeparator + "myFile.txt";
            if (File.Exists(path))
                File.Delete(path);
            File.Create(path);
            Assert.IsNotNull(NodesHelper.CollectInfo(path));
        }

        [TestMethod]
        [ExpectedException(typeof(DirectoriesApplicationException))]
        public void CollectInfoFailTest()
        {
            var path = Environment.CurrentDirectory + Path.PathSeparator + "myFile.txt";
            if (File.Exists(path))
                File.Delete(path);
            NodesHelper.CollectInfo(path);
        }

        [TestMethod]
        public void LoadInfoTest()
        {
            var info = NodesHelper.LoadInfo(@"<?xml version=""1.0"" encoding=""utf-16""?>
<DirectoryNode Name=""Directory"">
  <DirectoryNode Name=""EmptyDir"" />
  <FileNode Name=""NewFile.xml"" Size=""256"" LastDateChanged=""11/15/2010"" />
</DirectoryNode>");
            Assert.IsInstanceOfType(info, typeof(DirectoryNode));
        }

        [TestMethod]
        public void StoreInfoTest()
        {
            var xml = NodesHelper.StoreInfo(new FileNode { Name = "TEST", Size = 200, LastDateChanged = DateTime.Today });
            Assert.IsTrue(xml.Contains("<FileNode "));
        }

        [TestMethod]
        public void CreateTest()
        {
            var path = Environment.CurrentDirectory + Path.PathSeparator + "TestFile.txt";
            if (File.Exists(path))
                File.Delete(path);
            NodesHelper.Create(new FileNode { Name = "TestFile.txt" }, Environment.CurrentDirectory);
            Assert.IsTrue(File.Exists(path));
        }
    }
}
