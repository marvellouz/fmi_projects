using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml;
using System.Globalization;
using System.Text.RegularExpressions;


namespace Task3
{
    [Flags]
    public enum CompareOptions
    {
        None = 0,
        IgnoreCase = 1,
        IgnoreOrder = 2,
        IgnoreRepeat = 4
    }

    public class XmlComparer
    {
        public static bool compareNodes(XmlNode node1, XmlNode node2)
        {
            if (node1.InnerText == node2.InnerText)
            {
                if ((node1.Name == node2.Name) &&
                    (node1.Attributes.Count == node2.Attributes.Count))
                {
                    if (node1.Attributes.Count != 0)
                    {
                        for (int i = 1; i < node1.Attributes.Count; i++)
                        {
                            if (node1.Attributes[i].Name != node2.Attributes[i].Name)
                            {
                                return false;
                            }
                        }
                        return true;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public static bool compareNormal(XmlNode rootNode1, XmlNode rootNode2)
        {
            if (!compareNodes(rootNode1, rootNode2))
            {
                return false;
            }
            
            if (rootNode1.ChildNodes.Count != rootNode2.ChildNodes.Count)
            {
                return false;
            }

            for (int i = 0; i < rootNode1.ChildNodes.Count; i++)
            {
                if (!compareNormal(rootNode1.ChildNodes[i], rootNode2.ChildNodes[i]))
                {
                    return false;
                }
            }
            return true;
        }


        public static bool Compare(string xml1, string xml2, CompareOptions options)
        {
            XmlDocument xdoc1 = new XmlDocument();
            xdoc1.LoadXml(xml1);
            XmlNode rootNode1 = xdoc1.DocumentElement;

            XmlDocument xdoc2 = new XmlDocument();
            xdoc2.LoadXml(xml2);
            XmlNode rootNode2 = xdoc2.DocumentElement;

            if (options == 0)
            {
                return Regex.Replace(xml1, @"\s", "") == Regex.Replace(xml2, @"\s", "");
            }

            if ((options & CompareOptions.IgnoreCase) != 0)
            {
                string xml1Lower = xml1.ToLower();
                XmlDocument xdoc1Lower = new XmlDocument();
                xdoc1Lower.LoadXml(xml1Lower);
                XmlNode rootNode1Lower = xdoc1Lower.DocumentElement;

                string xml2Lower = xml2.ToLower();
                XmlDocument xdoc2Lower = new XmlDocument();
                xdoc2Lower.LoadXml(xml2Lower);
                XmlNode rootNode2Lower = xdoc2Lower.DocumentElement;
            }

            return false;
        }
    }
 





    class Program
    {
        static void Main(string[] args)
        {
             
string xml1 = @" 
                <Root> 
                    <Element Attribute1=""value1"" >some content</Element> 
                    <Element1  Attribute1=""value1"">some content</Element1>
                    <Element2  Attribute1=""value1"">some content
                        <Element22  Attribute1=""value1"">some content</Element22> 
                    </Element2> 
                </Root>";
 
string xml2 = @"
                <Root>
                    <Element Attribute1=""value1"" >some content</Element>
                    <Element1  Attribute1=""value1"">some content</Element1>
                    <Element2  Attribute1=""value1"">some content
                        <Element22  Attribute1=""value1"">some content</Element22> 
                    </Element2> 
                </Root>";
XmlComparer.Compare(xml1, xml2, CompareOptions.None);
XmlComparer.Compare(xml1, xml2, CompareOptions.IgnoreCase);
 
        }
    }
}
