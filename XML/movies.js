var doc = new ActiveXObject("MSXML.DOMDocument");
var rootElem = doc.createElement('Body');
doc.appendChild(rootElem);
var childElem = doc.createElement('Movie')
rootElem.appentsChild(childElem);
var subChild = doc.createElement('Title')
childElem.appendChild(subChild)
var content = doc.createTextNode('City Lights');
subChild.appendChild(content);
content = doc.createTextNode('1931')
subChild.appendChild(content);
