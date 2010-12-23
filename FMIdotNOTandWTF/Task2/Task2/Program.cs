using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml;
using System.Globalization;

namespace Task2
{
    public class  DirectoriesApplicationException : System.Exception
    {
        public  DirectoriesApplicationException()
        {
        }

        public  DirectoriesApplicationException(string message)
            : base(message)
        {
        }

        public DirectoriesApplicationException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }

    public class Node
    {
        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
    }

    public class FileNode : Node
    {
        private long size;
        private DateTime last_date_changed;

        public long Size
        {
            get { return size; }
            set { size = value; }
        }

        public DateTime LastDateChanged
        {
            get { return last_date_changed; }
            set { last_date_changed = value; }
        }
    }

    public class DirectoryNode : Node
    {
        private List<Node> children;

        public List<Node> Children
        {
            get { return children; }
            set { children = value; }
        }
    }

    public static class NodesHelper
    {
        public static Node CollectInfo(string path)
        {
                if (File.Exists(path))
                {
                    FileNode file_info = new FileNode();
                    System.IO.FileInfo fi = new System.IO.FileInfo(path);
                    file_info.Name = path;
                    file_info.Size = fi.Length;
                    file_info.LastDateChanged = fi.LastWriteTime;
                    return file_info;
                }

                if (Directory.Exists(path))
                {
                    DirectoryNode dir = new DirectoryNode();
                    dir.Name = path;
                    foreach (string d in Directory.GetFileSystemEntries(dir.Name))
                    {
                        dir.Children.Add(CollectInfo(d));
                    }
                    return dir;
                }
                else
                {
                    throw new DirectoriesApplicationException("The file/directory is missing.");
                }
            }

        public static Node MakeFileOrDirNode(XmlNode rootNode)
        {
            if (rootNode.Name == "FileNode")
            {
                FileNode file_info = new FileNode();
                file_info.Name = rootNode.Attributes["Name"].Value;
                file_info.Size =Convert.ToInt32(rootNode.Attributes["Size"].Value);
                DateTime formatted = DateTime.ParseExact(rootNode.Attributes["LastDateChanged"].Value,
                    "MM/dd/yyyy", CultureInfo.InvariantCulture);
                file_info.LastDateChanged = formatted;
                return file_info;
            }
            //if (rootNode.Name == "DirectoryNode")
            else
            {
                DirectoryNode dir = new DirectoryNode();
                dir.Name = rootNode.Attributes["Name"].Value;
                foreach (XmlNode n in rootNode.ChildNodes)
                {
                    Console.WriteLine(MakeFileOrDirNode(n));
                    //dir.Children.Add(MakeFileOrDirNode(n));
                }
                return dir;
            }
        }

        public static Node LoadInfo(string xml)
        {
            XmlDocument xdoc = new XmlDocument();
            xdoc.LoadXml(xml);
            XmlNode rootNode = xdoc.DocumentElement;
            Console.WriteLine(MakeFileOrDirNode(rootNode).Name);
            return MakeFileOrDirNode(rootNode);
        }


    }


    class Program
    {
        static void Main(string[] args)
        {
            var info = NodesHelper.LoadInfo(@"<?xml version=""1.0"" encoding=""utf-16""?>
<DirectoryNode Name=""Directory"">
  <FileNode Name=""NewFile.xml"" Size=""256"" LastDateChanged=""11/15/2010"" />
</DirectoryNode>");
        }
    }
}
