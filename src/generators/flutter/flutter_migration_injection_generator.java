package generators.flutter;

import annotations.InjectIntoParam;
import core.FluxiBag;

public class flutter_migration_injection_generator
{
    FluxiBag fluxiBag;

    public flutter_migration_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

    @InjectIntoParam(name = "FLUTTER_MIGRATION_FIELDS_LIST")
    public String generateFieldsListForFlutterClass()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("              +\"");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(" ");
            stringBuilder.append(fluxiBag.params[i].toSQFLiteType());

            if ( i < fluxiBag.params.length-1 )
            {
                stringBuilder.append(", \"");
                stringBuilder.append(System.getProperty("line.separator"));
            } else {
                stringBuilder.append("\"");
            }
        }
        return stringBuilder.toString();
    }

}
