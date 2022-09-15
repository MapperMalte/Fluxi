package generators.phoenix;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import core.FluxiBag;

@MovedTo(path = "#ELIXIR_ROOT/lib/#nAME_web/channels")
public class phoenix_channel_injection_generator
{
    FluxiBag fluxiBag;

    public phoenix_channel_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

    @InjectIntoParam(name = "FIELDS_LIST_FOR_PATTERN_MATCHING_MAP")
    public String generateFieldsListPatternMatchingMap()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("    ");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(" => ");
            stringBuilder.append(fluxiBag.params[i].name);
            if ( i < fluxiBag.params.length-1 )
            {
                stringBuilder.append(", ");
                stringBuilder.append(System.getProperty("line.separator"));
            }
        }
        return stringBuilder.toString();
    }

    @InjectIntoParam(name = "FIELDS_LIST_FOR_CHANGESET")
    public String generateFieldsListForChangeset()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("                    \"");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append("\": ");
            stringBuilder.append(fluxiBag.params[i].name);
            if ( i < fluxiBag.params.length-1 )
            {
                stringBuilder.append(", ");
                stringBuilder.append(System.getProperty("line.separator"));
            }
        }
        return stringBuilder.toString();
    }
}
