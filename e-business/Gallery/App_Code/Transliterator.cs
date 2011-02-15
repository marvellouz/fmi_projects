using System.Collections.Generic;

public static class Transliterator
{
    private static Dictionary<char, string> translDict;

    static Transliterator()
    {
        translDict = new Dictionary<char, string>();
        initDictionary();
    }

    public static string bgToLatin(string bgText)
    {
        string latinText = "";
        foreach (char letter in bgText)
        {
            string tmp = letter.ToString();
            if (translDict.ContainsKey(letter))
            {
                tmp = translDict[letter];
            }
            latinText += tmp;
        }
        return latinText;
    }

    private static void initDictionary()
    {
        translDict.Add('�', "a");
        translDict.Add('�', "b");
        translDict.Add('�', "v");
        translDict.Add('�', "g");
        translDict.Add('�', "d");
        translDict.Add('�', "e");
        translDict.Add('�', "zh");
        translDict.Add('�', "z");
        translDict.Add('�', "i");
        translDict.Add('�', "y");
        translDict.Add('�', "k");
        translDict.Add('�', "l");
        translDict.Add('�', "m");
        translDict.Add('�', "n");
        translDict.Add('�', "o");
        translDict.Add('�', "p");
        translDict.Add('�', "r");
        translDict.Add('�', "s");
        translDict.Add('�', "t");
        translDict.Add('�', "u");
        translDict.Add('�', "f");
        translDict.Add('�', "h");
        translDict.Add('�', "ts");
        translDict.Add('�', "tch");
        translDict.Add('�', "sh");
        translDict.Add('�', "sht");
        translDict.Add('�', "u");
        translDict.Add('�', "y");
        translDict.Add('�', "yu");
        translDict.Add('�', "ya");
        translDict.Add('�', "A");
        translDict.Add('�', "B");
        translDict.Add('�', "V");
        translDict.Add('�', "G");
        translDict.Add('�', "D");
        translDict.Add('�', "E");
        translDict.Add('�', "Zh");
        translDict.Add('�', "Z");
        translDict.Add('�', "I");
        translDict.Add('�', "Y");
        translDict.Add('�', "K");
        translDict.Add('�', "L");
        translDict.Add('�', "M");
        translDict.Add('�', "N");
        translDict.Add('�', "O");
        translDict.Add('�', "P");
        translDict.Add('�', "R");
        translDict.Add('�', "S");
        translDict.Add('�', "T");
        translDict.Add('�', "U");
        translDict.Add('�', "F");
        translDict.Add('�', "H");
        translDict.Add('�', "Ts");
        translDict.Add('�', "Tch");
        translDict.Add('�', "Sh");
        translDict.Add('�', "Sht");
        translDict.Add('�', "U");
        translDict.Add('�', "Y");
        translDict.Add('�', "Yu");
        translDict.Add('�', "Ya");
    }
}
