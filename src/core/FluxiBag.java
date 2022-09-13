package core;

import misc.CaseTransformer;

public class FluxiBag
{
    public FluxiParam[] params;
    public String name;
    public String elixir_root = "FinalLocallity";

    public void addUUID() {
        FluxiParam[] newParams = new FluxiParam[params.length+1];
        newParams[0] = new FluxiParam(FluxiType.STRING,CaseTransformer.toSnakeCase(name)+"_uuid");
        for(int i = 0; i < params.length; i++)
        {
            newParams[i+1] = params[i];
        }
        this.params = newParams;
    }
}
