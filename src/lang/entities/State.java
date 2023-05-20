package lang.entities;

import core.FluxiType;
import theory.DiamondList;

public class State {
    String name;
    FluxiType type;
    
    DiamondList<Mutation> mutations;
}
