package generators.flutter;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import core.FluxiBag;

@MovedTo(path = "#FLUTTER_ROOT/lib/fluxi/")
public class flutter_model_injection_generator
{
    FluxiBag fluxiBag;

    public flutter_model_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

    @InjectIntoParam(name = "FLUTTER_CLASS_FIELDS_LIST")
    public String generateFieldsListForFlutterClass()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("  ");
            stringBuilder.append(fluxiBag.params[i].toFlutterType());
            stringBuilder.append("? ");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(";");
            if ( i < fluxiBag.params.length-1 ) stringBuilder.append(System.getProperty("line.separator"));
        }
        return stringBuilder.toString();
    }

    @InjectIntoParam(name = "FIELDS_LIST_FOR_MAP_CONSTRUCTOR")
    public String generateFieldsListForFlutterMapConstructor()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("    this.");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(" = map['");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append("'];");
            if ( i < fluxiBag.params.length-1 ) stringBuilder.append(System.getProperty("line.separator"));
        }
        return stringBuilder.toString();
    }

    // COLUMN_public: public ? 1 : 0,
    @InjectIntoParam(name = "FIELDS_LIST_FOR_MAP_GENERATOR")
    public String generateFieldsListForFlutterMapGenerator()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("      \"");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append("\": ");
            stringBuilder.append(fluxiBag.params[i].name);

            if ( i < fluxiBag.params.length-1 ){
                stringBuilder.append(",");
                stringBuilder.append(System.getProperty("line.separator"));
            }
        }
        return stringBuilder.toString();
    }
}
