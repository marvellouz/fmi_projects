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
            if (node1.InnerText != node2.InnerText || node1.Name != node2.Name)
            {
                return false;
            }

            if ((node1.Attributes == null || node2.Attributes == null))
            {

                return node1.Attributes == node2.Attributes;
            }

            if ((node1.Attributes.Count != node2.Attributes.Count))
            {
                return false;
            }

            for (int i = 0; i < node1.Attributes.Count; i++)
            {
                if (node1.Attributes[i].Name != node2.Attributes[i].Name)
                {
                    return false;
                }
            }

            return true;
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

        public static XmlDocument SortedXml(XmlDocument xdoc)
        {
            return xdoc;
        }

        public static XmlDocument UniqueXml(XmlDocument xdoc)
        {
            return xdoc;
        }


        public static bool Compare(string xml1, string xml2, CompareOptions options)
        {
            if (options == 0)
            {
                return Regex.Replace(xml1, @"\s", "") == Regex.Replace(xml2, @"\s", "");
            }

            if ((options & CompareOptions.IgnoreCase) != 0) {
                xml1 = xml1.ToLower();
                xml2 = xml2.ToLower();
            }

            XmlDocument xdoc1 = new XmlDocument();
            xdoc1.LoadXml(xml1);

            XmlDocument xdoc2 = new XmlDocument();
            xdoc2.LoadXml(xml2);

            if ((options &CompareOptions.IgnoreRepeat)!=0) {
                xdoc1 = UniqueXml(xdoc1);
                xdoc2 = UniqueXml(xdoc2);
            }

            if ((options &CompareOptions.IgnoreOrder)!=0) {
                xdoc1 = SortedXml(xdoc1);
                xdoc2 = SortedXml(xdoc2);
            }

            return compareNormal(xdoc1.DocumentElement, xdoc2.DocumentElement);

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
