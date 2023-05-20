package generators;

import com.sun.deploy.util.StringUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class fluxi_injection_generator
{
    public static void compile()
    {
        Map<String,String> tokens = new HashMap<String,String>();
        tokens.put("cat", "Garfield");
        tokens.put("beverage", "coffee");

        String template = "%cat% really needs some %beverage%.";

        String patternString = "%(" + StringUtils.join(tokens.keySet(), "|") + ")%";
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(template);

        StringBuffer sb = new StringBuffer();
        while(matcher.find()) {
            matcher.appendReplacement(sb, tokens.get(matcher.group(1)));
        }
        matcher.appendTail(sb);

        System.out.println(sb.toString());
    }
}