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


        public static XmlDocument UniqueXml(XmlDocument xdoc)
        {
            return xdoc;
        }


         public static XmlDocument SortedXml(XmlDocument xdoc) {
            SortXml(xdoc.DocumentElement);
            return xdoc;
        }

        public static void SortXml(XmlNode rootNode) {
            SortAttributes(rootNode.Attributes);
            SortElements(rootNode);
            foreach (XmlNode childNode in rootNode.ChildNodes) {
                SortXml(childNode);
            }   
        }   

        public static void SortAttributes(XmlAttributeCollection attribCol) {
            if (attribCol == null) 
                return;                

            bool hasChanged = true;
            while (hasChanged) {
                hasChanged = false;
                for (int i = 1; i < attribCol.Count; i++) {
                    if (String.Compare(attribCol[i].Name, attribCol[i-1].Name, true) < 0) {
                        //Replace
                        attribCol.InsertBefore(attribCol[i], attribCol[i - 1]);
                        hasChanged = true;
                    }
                }
            }

        }

        public static void SortElements(XmlNode node) {
            bool changed = true;
            while (changed) {
                changed = false;
                for (int i = 1; i < node.ChildNodes.Count; i++) {
                    if (String.Compare(node.ChildNodes[i].Name, node.ChildNodes[i-1].Name, true) < 0) {
                        //Replace:
                        node.InsertBefore(node.ChildNodes[i], node.ChildNodes[i-1]);
                        changed = true;
                    }
                }
            }
        }

        public static bool Compare(string xml1, string xml2, CompareOptions options)
        {
            if (options == 0)
            {
                return Regex.Replace(xml1, @"\s", "") == Regex.Replace(xml2, @"\s", "");
            }

            if ((options & CompareOptions.IgnoreCase) != 0)
            {
                xml1 = xml1.ToLower();
                xml2 = xml2.ToLower();
            }

            XmlDocument xdoc1;
            XmlDocument xdoc2;

            if ((options & CompareOptions.IgnoreRepeat) != 0)
            {
                xdoc1 = new XmlDocument();
                xdoc1.LoadXml(xml1);

                xdoc2 = new XmlDocument();
                xdoc2.LoadXml(xml2);

                UniqueXml(xdoc1);
                UniqueXml(xdoc2);
                if (!compareNormal(xdoc1.DocumentElement, xdoc2.DocumentElement))
                {
                    return false;
                }
            }

            if ((options & CompareOptions.IgnoreOrder) != 0)
            {
                xdoc1 = new XmlDocument();
                xdoc1.LoadXml(xml1);

                xdoc2 = new XmlDocument();
                xdoc2.LoadXml(xml2);

                SortedXml(xdoc1);
                SortedXml(xdoc2);
                if (!compareNormal(xdoc1.DocumentElement, xdoc2.DocumentElement))
                {
                    return false;
                }
            }

            xdoc1 = new XmlDocument();
            xdoc1.LoadXml(xml1);

            xdoc2 = new XmlDocument();
            xdoc2.LoadXml(xml2);

            return compareNormal(xdoc1.DocumentElement, xdoc2.DocumentElement);

        }


    }


    class Program
    {
        static void Main(string[] args)
        {

        }
    }
}
