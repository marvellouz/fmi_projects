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
        translDict.Add('à', "a");
        translDict.Add('á', "b");
        translDict.Add('â', "v");
        translDict.Add('ã', "g");
        translDict.Add('ä', "d");
        translDict.Add('å', "e");
        translDict.Add('æ', "zh");
        translDict.Add('ç', "z");
        translDict.Add('è', "i");
        translDict.Add('é', "y");
        translDict.Add('ê', "k");
        translDict.Add('ë', "l");
        translDict.Add('ì', "m");
        translDict.Add('í', "n");
        translDict.Add('î', "o");
        translDict.Add('ï', "p");
        translDict.Add('ð', "r");
        translDict.Add('ñ', "s");
        translDict.Add('ò', "t");
        translDict.Add('ó', "u");
        translDict.Add('ô', "f");
        translDict.Add('õ', "h");
        translDict.Add('ö', "ts");
        translDict.Add('÷', "tch");
        translDict.Add('ø', "sh");
        translDict.Add('ù', "sht");
        translDict.Add('ú', "u");
        translDict.Add('ü', "y");
        translDict.Add('þ', "yu");
        translDict.Add('ÿ', "ya");
        translDict.Add('À', "A");
        translDict.Add('Á', "B");
        translDict.Add('Â', "V");
        translDict.Add('Ã', "G");
        translDict.Add('Ä', "D");
        translDict.Add('Å', "E");
        translDict.Add('Æ', "Zh");
        translDict.Add('Ç', "Z");
        translDict.Add('È', "I");
        translDict.Add('É', "Y");
        translDict.Add('Ê', "K");
        translDict.Add('Ë', "L");
        translDict.Add('Ì', "M");
        translDict.Add('Í', "N");
        translDict.Add('Î', "O");
        translDict.Add('Ï', "P");
        translDict.Add('Ð', "R");
        translDict.Add('Ñ', "S");
        translDict.Add('Ò', "T");
        translDict.Add('Ó', "U");
        translDict.Add('Ô', "F");
        translDict.Add('Õ', "H");
        translDict.Add('Ö', "Ts");
        translDict.Add('×', "Tch");
        translDict.Add('Ø', "Sh");
        translDict.Add('Ù', "Sht");
        translDict.Add('Ú', "U");
        translDict.Add('Ü', "Y");
        translDict.Add('Þ', "Yu");
        translDict.Add('ß', "Ya");
    }
}
