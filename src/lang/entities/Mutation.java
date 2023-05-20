package lang.entities;

import core.FluxiParam;
import core.FluxiType;
import lang.Lexable;
import theory.DiamondList;

public class Mutation implements Lexable
{
    String name;
    FluxiType mutatedType;
    DiamondList<FluxiParam> expectedFields;

    @Override
    public boolean isLeaf() {
        return true;
    }
}
