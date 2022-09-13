package misc;

public class CaseTransformer
{
    public static String firstLetterBig(String s)
    {
        if ( s == null || s.length() == 0 ) return s;
        if ( s.length() == 1 ) return Character.toUpperCase(s.charAt(0))+"";
        return Character.toUpperCase(s.charAt(0))+s.substring(1);
    }

    public static String toSnakeCase(String in)
    {
        StringBuilder out = new StringBuilder();
        for(int i = 0; i < in.length(); i++)
        {
            if (Character.isUpperCase(in.charAt(i)) )
            {
                if ( i > 0 )
                {
                    out.append("_");
                }
                out.append(Character.toLowerCase(in.charAt(i)));
            } else {
                out.append(in.charAt(i));
            }
        }
        return out.toString();
    }
}