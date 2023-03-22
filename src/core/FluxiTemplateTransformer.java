package core;

import annotations.InjectIntoParam;
import misc.CaseTransformer;

import java.io.*;
import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;

public class FluxiTemplateTransformer
{
    static String getProjectFileRoot()
    {
        return System.getProperty("user.dir");
    }

    // Connect Annotation to method
    public static String transformTemplate(
        String templateName,
        Object paramInjecter,
        FluxiBag fluxiBag,
        String folder,
        String ending
    )
    {
        File template = new File(getProjectFileRoot()+"/templates/"+templateName);
        File output = new File(getProjectFileRoot()+"/default_output/" + folder +"/"+
                CaseTransformer.toSnakeCase(fluxiBag.name)+"/"+CaseTransformer.toSnakeCase(fluxiBag.name)+ending);
        new File(getProjectFileRoot()+"/default_output/" + folder +"/"+
                CaseTransformer.toSnakeCase(fluxiBag.name)+"/").mkdirs();

        System.out.println("OUTPUT: "+output.getAbsolutePath());

        Annotation[] annotations = paramInjecter.getClass().getAnnotations();
        ArrayList<FluxiReflection> fluxiInjectors = new ArrayList<>();
        Method[] methods = paramInjecter.getClass().getDeclaredMethods();

        for(int m = 0; m < methods.length; m++)
        {
            if ( methods[m].isAnnotationPresent(InjectIntoParam.class) )
            {
                InjectIntoParam injectorAnnotation = methods[m].getAnnotation(InjectIntoParam.class);
                fluxiInjectors.add(new FluxiReflection(methods[m],injectorAnnotation.name()));
            }
        }

        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(template));
            BufferedWriter bufferedWriter = new BufferedWriter((new FileWriter(output)));
            String line = "";
            String outputline = "";
            while ( (line = bufferedReader.readLine() ) != null )
            {
                outputline = line
                            .replaceAll("#NAME_SNAKE_CASE", CaseTransformer.toSnakeCase(fluxiBag.name))
                            .replaceAll("#NAME",fluxiBag.name)
                            .replaceAll("#nAME", CaseTransformer.toSnakeCase(fluxiBag.name))
                            .replaceAll("#ELIXIR_ROOT",fluxiBag.elixir_root);
                int hashtag_index = line.indexOf("#");
                while ( hashtag_index != -1 )
                {
                    for(int i = 0; i < fluxiInjectors.size(); i++)
                    {
                        String param_name = fluxiInjectors.get(i).paramName;
                         if (line.length() >= hashtag_index+param_name.length()+1)
                         {
                             String substring = line.substring(hashtag_index, hashtag_index + param_name.length()+1);
                             if ( substring.equals("#"+param_name) )
                             {
                                 Object invokeResult = fluxiInjectors.get(i).method.invoke(paramInjecter);
                                 outputline = outputline.replaceAll(substring,invokeResult.toString());
                             }
                         }
                    }
                    hashtag_index = line.indexOf("#",hashtag_index+1);
                }
                bufferedWriter.write(outputline);
                bufferedWriter.newLine();
            }
            bufferedWriter.flush();
            bufferedWriter.close();
            bufferedReader.close();

            if ( ending.endsWith(".sh") )
            {
                output.setExecutable(true);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        return "";
    }
}