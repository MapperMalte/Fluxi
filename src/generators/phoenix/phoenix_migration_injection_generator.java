package generators.phoenix;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import annotations.TargetPathGenerator;
import core.FluxiBag;

@MovedTo(path = "#ELIXIR_ROOT/priv/repo/migrations")
public class phoenix_migration_injection_generator
{
    FluxiBag fluxiBag;
    public phoenix_migration_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

    public String generate()
    {
        StringBuilder sb = new StringBuilder();

        return  sb.toString();
    }
    
    @InjectIntoParam(name = "FIELDS_LIST_FOR_TABLE_CREATION")
    public String generateFieldsListForTableCreation()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("      add :");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append(", :");
            stringBuilder.append(fluxiBag.params[i].toElixirType());
            stringBuilder.append(System.getProperty("line.separator"));
        }
        return stringBuilder.toString();
    }
}
