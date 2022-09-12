package core;

public enum FluxiType
{
    INTEGER, STRING, BOOLEAN, DATE;

    public static FluxiType parse(String atom_atom) {
        switch (atom_atom)
        {
            case "integer": return INTEGER;
            case "string": return STRING;
            case "boolean": return BOOLEAN;
            case "date": return DATE;
        }
        return null;
    }
}
