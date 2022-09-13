package generators.phoenix;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import annotations.TargetPathGenerator;
import core.FluxiBag;

@MovedTo(path = "#ELIXIR_ROOT/lib/fluxi_generated/#nAME")
public class phoenix_model_injection_generator
{
    FluxiBag fluxiBag;

    public phoenix_model_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

    @InjectIntoParam(name = "FIELDS_LIST_FOR_SCHEMA")
    public String generateFieldsListForSchema()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("    field :");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(", :");
            stringBuilder.append(fluxiBag.params[i].toElixirType());
            if ( i < fluxiBag.params.length-1 ) stringBuilder.append(System.getProperty("line.separator"));
        }
        return stringBuilder.toString();
    }

    @InjectIntoParam(name = "FIELDS_LIST_FOR_JASON_ENCODER")
    public String generateFieldsListForJasonEncoder()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("    :");
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
            stringBuilder.append(":");
            stringBuilder.append(fluxiBag.params[i].name);
            if ( i < fluxiBag.params.length-1 ) stringBuilder.append(", ");
        }
        return stringBuilder.toString();
    }
}