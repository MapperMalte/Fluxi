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
            case DATE: return "bigint";
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
            case DATE: return "DateTime";
        }
        return "--UNKNOWN TYPE--";
    }

    public String toSQFLiteType()
    {
        switch (fluxiType)
        {
            case INTEGER:
            case DATE:
                return "INTEGER";
            case STRING: return "TEXT";
        }
        return "--UNKNOWN TYPE--";
    }
}