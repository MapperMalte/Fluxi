package core;

public class FluxiParam
{
    public FluxiType fluxiType;
    public String name;

    public FluxiParam(FluxiType fluxiType, String name)
    {
        this.fluxiType = fluxiType;
        this.name = name;
    }

    public String toElixirType()
    {
        switch (fluxiType)
        {
            case INTEGER: return "integer";
            case STRING: return "string";
            case BOOLEAN: return "boolean";
        }
        return "--UNKNOWN TYPE--";
    }

    public String toFlutterType()
    {
        switch (fluxiType)
        {
            case INTEGER: return "int";
            case STRING: return "String";
            case BOOLEAN: return "bool";
        }
        return "--UNKNOWN TYPE--";
    }

    public String toSQFLiteType()
    {
        switch (fluxiType)
        {
            case INTEGER: return "INTEGER";
            case STRING: return "TEXT";
        }
        return "--UNKNOWN TYPE--";
    }
}