using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Globalization;

namespace XMLDemo
{
    class Program
    {
        /// <summary>
        /// This is my function description.
        /// It is in a special XML construct called XML documentation
        /// </summary>
        /// <param name="args">This is the description of my parameter - what I use it for and what values are valid...</param>
        static void Main(string[] args)
        {
            //ParseDocumentDOM();
            //ModifyDocumentDOM();
            //CreateDocumentDOM();
            //ParseDocumentSAX();
            //CreateDocumentSAX();
            //ParseDocumentXPathNavigator();
            //ParseDocumentXPath();
            //ValidateDocument();
            //TransformDocument();
        }

        public static void ParseDocumentDOM()
        {
            //Зареждаме XML документа, за да можем да го обработваме 
            XmlDocument xdoc = new XmlDocument();
            //xdoc.PreserveWhitespace = true;
            xdoc.Load("../../Resources/XMLs/Menu_ns.xml");
            Console.WriteLine("Count of child items: {0}", xdoc.DocumentElement.ChildNodes.Count);


            //Изписваме съдържанието му на конзолата
            Console.WriteLine("Loaded XML document:");
            Console.WriteLine(xdoc.OuterXml);
            Console.WriteLine();

            //Отпечатваме името на документния елемент и namespace-а му
            XmlNode rootNode = xdoc.DocumentElement;
            Console.WriteLine("Root node: {0}", rootNode.Name);
            Console.WriteLine("Root namespace: {0}", rootNode.NamespaceURI);

            //Отпечатване стойността на всеки атрибут на документния елемент 
            foreach (XmlAttribute atr in rootNode.Attributes)
            {
                Console.WriteLine("Attribute: {0}={1}", atr.Name, atr.Value);
            }

            //Извеждаме малка справка за броя предлаганите храни/напитки в менюто
            Console.WriteLine();
            Console.WriteLine("Our menu has {0} items", rootNode.FirstChild.ChildNodes.Count);
            Console.WriteLine();

            //обхождаме всички възли в XML документа, които се намират под първия поделемент 
            //на документния елемент
            //т.е. /документен елемент/първи наследник/възли
            foreach (XmlNode node in rootNode.FirstChild.ChildNodes)
            {
                //за всеки избран възел отпечатване атрибута му id
                Console.WriteLine("Food item No. {0}", node.Attributes["id"].Value);

                //отпечатваме и детайлите за него
                Console.WriteLine("Item : {0}", node["brk:name"].InnerText);
                Console.WriteLine("Description : {0}", node["brk:description"].InnerText);
                Console.WriteLine("Price : {0}", node["brk:price"].InnerText);

                //тъй като напитките нямат указани калории трябва да се погрижим да търсим 
                //информация за калории само на приложимите места
                if (node.Name == "foodItem")
                    Console.WriteLine("Calories : {0}", node["brk:calories"].InnerText);
                Console.WriteLine();
            }
        }

        public static void ModifyDocumentDOM()
        {
            //Зареждаме XML документа, за да можем да го обработваме 
            XmlDocument doc = new XmlDocument();
            doc.Load("../../Resources/XMLs/Menu_ns.xml");

            //обхождаме всички възли в XML документа, които се намират под първия поделемент 
            //на документния елемент
            foreach (XmlNode node in doc.DocumentElement.FirstChild.ChildNodes)
            {
                //целта ни в примера е да удвоим цената на точно определен продукт, за който знаем id
                //за други цели можем да извършваме произволни проверки за имена на елементи или стойности на атрибути
                if (node.Attributes["id"].Value == "006")
                {
                    //прочитаме текущата стойност в елемента price като текст
                    string currentPriceStr = node["brk:price"].InnerText;
                    //конвертираме към число от тип double, за да можем да умножаваме
                    decimal currentPrice = Decimal.Parse(currentPriceStr, CultureInfo.InvariantCulture);
                    decimal newPrice = currentPrice * 2;
                    //записваме новата стойност обратно в текстовата вътрешна част на елемента
                    node["brk:price"].InnerText = newPrice.ToString(CultureInfo.InvariantCulture);

                    //не е лоша идея да "оставим следа" след промяната си
                    //в описанието на продукта добавяме по аналогичен начин датата на промяна на цената
                    string currentDescription = node["brk:description"].InnerText;
                    currentDescription += " (price updated : " + DateTime.Today.ToShortDateString() + ")";
                    node["brk:description"].InnerText = currentDescription;
                }
            }

            //запазваме така полученото меню в текущата директория с ново име
            doc.Save("../../Resources/XMLs/UpdatedMenu.xml");
        }

        public static void CreateDocumentDOM()
        {
            //създаваме обект от тип XmlDocument, който да съдържа документа ни
            XmlDocument xmlDoc = new XmlDocument();

            //записваме XML декларацията на документа в началото му 
            XmlDeclaration docDeclaration = xmlDoc.CreateXmlDeclaration("1.0", "UTF-8", "yes");
            xmlDoc.AppendChild(docDeclaration);

            //документният елемент ще се нарича "order" 
            //създаваме го и го добавяме в документа
            XmlElement docElement = xmlDoc.CreateElement("order");
            xmlDoc.AppendChild(docElement);

            //използваме помощна функция за добавянето на поделементите
            AppendItem(xmlDoc, docElement, "Berry-Berry Belgian Waffles", 2);
            AppendItem(xmlDoc, docElement, "Coffee", 1);

            //накрая запазваме документа си в текущата директория под името "order.xml"
            xmlDoc.Save("../../Resources/XMLs/Order.xml");
        }

        private static void AppendItem(XmlDocument aXmlDoc, XmlElement aXmlElement, string aItemName, int aAmmount)
        {
            //за целите на примера имаме фиксирана структура
            //в реална функция можете да пробвате с подаване на списък от двойки атрибут/стойност и наследник/текст

            //създаваме елемент item
            XmlElement itemElement = aXmlDoc.CreateElement("item");
            //текстът в него е подаденият за името на продукта
            itemElement.InnerText = aItemName;
            //към елемента добавяме атрибут с име "quantiy" и стойност исканото количество
            XmlAttribute ammountAttr = aXmlDoc.CreateAttribute("quantiy");
            ammountAttr.Value = aAmmount.ToString();
            itemElement.Attributes.Append(ammountAttr);
            aXmlElement.AppendChild(itemElement);
        }

        public static void ParseDocumentSAX()
        {
            Console.WriteLine("Menu items:");
            //инициализираме XmlTextReader-a
            XmlTextReader reader = new XmlTextReader("../../Resources/XMLs/Menu_ns.xml");

            //четем последователно възел по възел
            while (reader.Read())
            {
                //ако разглежданият възел е от тип елемент и името му съвпада с посоченото
                //отпечатваме текста в него на конзолата
                if ((reader.NodeType == XmlNodeType.Element) && (reader.Name == "brk:name"))
                {
                    Console.WriteLine(reader.ReadElementString());
                }
            }

            //искаме да изведем и имената на елементите във файла
            Console.WriteLine("\nElement names in the XML file:");

            //тъй като XmlReader е еднопосочен, трябва да го инициализираме отново
            reader = new XmlTextReader("../../Resources/XMLs/Menu_ns.xml");

            //аналогично, четем последователно възел по възел и за възлите от тип елемент отпечатваме имената им
            while (reader.Read())
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    Console.WriteLine(reader.Name);
                }
            }
        }

        public static void CreateDocumentSAX()
        {
            //инициализираме нов XmlTextWriter с име на изходен файл и кодировка
            XmlTextWriter writer = new XmlTextWriter("../../Resources/XMLs/LunchMenu.xml", Encoding.GetEncoding("windows-1251"));

            //указваме как да се форматира документа, кой символ да се използва за отместване и колко такива да се поставят едно след друго
            writer.Formatting = Formatting.Indented;
            writer.IndentChar = '\t';
            writer.Indentation = 1;

            //за да разграничим елементите си ще добавим и namespace
            string ns = "http://fmi.silverlight.bg/Schemas/XMl/2009";

            //спомняте си за try-finally блоковете при потоци нали? :)
            try
            {
                //започваме писането в XmlTextWriter с XML декларацията
                writer.WriteStartDocument();
                //документният елемент се нарича "lunchMenu" и се намира в указания от нас namespace с префикс "lnch"
                writer.WriteStartElement("lnch", "lunchMenu", ns);
                //за документния елемент задаваме и атрибут за име от namespace-a
                writer.WriteAttributeString("lnch", "name", ns, "Today's lunch menu");

                //отново добавяме елементите с помощна функция:
                WriteFoodItem(writer, "Stuffed peppers", "Bulgarian red stuffed peppers served hot with yoghurt on the side", "4.50", ns);
                WriteFoodItem(writer, "Chicken with mashed potatoes", "Crispy chicken legs with fresh mashed potatoes on the side", "5.30", ns);
                WriteFoodItem(writer, "Spring vegetable soup", "Refreshing soup made of potatoes, tomatoes, beans, carrots and cucumbers", "2.60", ns);

                //завършваме документа
                writer.WriteEndDocument();
            }
            finally
            {
                //затваряме XmlTextWriter
                writer.Close();
            }
        }

        private static void WriteFoodItem(XmlWriter aWriter, string aName, string aDescription, string aPrice, string ns)
        {
            //всеки поделемент се присъединява към подадения namespace с определеното си име и текстова стойност
            aWriter.WriteStartElement("lnch", "foodItem", ns);
            aWriter.WriteElementString("lnch", "name", ns, aName);
            aWriter.WriteElementString("lnch", "description", ns, aDescription);
            aWriter.WriteElementString("lnch", "price", ns, aPrice);
            aWriter.WriteEndElement();
        }

        public static void ParseDocumentXPathNavigator()
        {
            //създаваме нов XPathDocument и XPathNavigator за него
            XPathDocument doc = new XPathDocument("../../Resources/XMLs/Menu_ns.xml");
            XPathNavigator navigator = doc.CreateNavigator();

            //позиционираме се на документния елемент
            navigator.MoveToRoot();
            //преместваме се на първия наследник
            navigator.MoveToFirstChild();

            //ако този пръв наследник има от своя страна други вложени елементи, слизаме навътре по дървото
            if (navigator.HasChildren)
                navigator.MoveToFirstChild();
            //докато можем да минем на следващ елемент от същото ниво
            do
            {
                //аналогично се навигираме по наследниците и достигайки нужния ни възел отпечатваме информация за него на конзолата
                if (navigator.HasChildren)
                {
                    navigator.MoveToFirstChild();
                    do
                    {
                        Console.WriteLine(navigator.Name);
                        Console.WriteLine(navigator.GetAttribute("id", ""));
                        navigator.MoveToFirstChild();
                        do
                        {
                            Console.WriteLine(navigator.InnerXml);
                            //navigator.MoveToParent();
                        }
                        while (navigator.MoveToNext());

                        //за да останем на предишното ниво се навигираме до родителския елемент
                        navigator.MoveToParent();
                    }
                    while (navigator.MoveToNext());
                }
            }
            while (navigator.MoveToNext());
        }

        public static void ParseDocumentXPath()
        {
            //Зареждаме XML документа, за да можем да го обработваме 
            XmlDocument doc = new XmlDocument();
            doc.Load("../../Resources/XMLs/BookStore.xml");

            //създаваме XmlNamespaceManager, за да използваме namespace-ите от самия документ и за правилно позициониране
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("bk", "urn:samples");

            //търсим под документния елемент такъв наследник (на произволно вложено ниво), който да има 
            //ISBN с точно определена стойност и от него вземаме книгата
            XmlNode book;
            XmlElement root = doc.DocumentElement;
            book = root.SelectSingleNode("descendant::book[@bk:ISBN='1-861001-57-6']", nsmgr);

            //записваме на конзолата целия елемент, който сме намерили
            Console.WriteLine(book.OuterXml);
        }

        public static void ValidateDocument()
        {
            // създаваме XmlSchemaSet обект, в който да сложим схемата си за валидиране на документ
            XmlSchemaSet sc = new XmlSchemaSet();

            // добавяме схемата 
            sc.Add("urn:bookstore-schema", "../../Resources/Schemas/BooksSchema.xsd");

            // Създаваме нов XmlReaderSettings обект
            XmlReaderSettings settings = new XmlReaderSettings();
            //ще валидираме с XSD schema
            settings.ValidationType = ValidationType.Schema;
            settings.Schemas = sc;

            //при възникване на проблем при валидация искаме да изпълним и наша дефинирана функция
            settings.ValidationEventHandler += new ValidationEventHandler(ValidationCallBack);

            // създаваме XmlReader за четене от файла за валидация
            XmlReader reader = XmlReader.Create("../../Resources/XMLs/BooksSchemaFail.xml", settings);

            // изчитаме файла докрая
            while (reader.Read()) ;

        }

        private static void ValidationCallBack(object sender, ValidationEventArgs e)
        {
            //при намиране на грешки при валидация ги отпечатваме на конзолата
            Console.WriteLine("Validation Error: {0}", e.Message);
            Console.WriteLine("\tSeverity:{0}", e.Severity);
            Console.WriteLine("\tMessage:{0}", e.Message);
        }

        public static void TransformDocument()
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load("../../Resources/XSLTs/style.xsl");
            xslt.Transform("../../Resources/XMLs/Inventory.xml", "../../Resources/XSLTs/XSLT_output.html");
        }
    }
}
