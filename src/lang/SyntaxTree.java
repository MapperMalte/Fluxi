package lang;

import theory.DiamondList;

public class SyntaxTree 
{
    DiamondList<SyntaxTree> children;

    boolean isLeaf(){
        return children.empty();
    }
}
