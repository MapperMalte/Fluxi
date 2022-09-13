package generators.phoenix;

import annotations.MovedTo;
import core.FluxiBag;

@MovedTo(path = "#ELIXIR_ROOT/lib/#nAME")
public class phoenix_repo_injection_generator
{
    FluxiBag fluxiBag;

    public phoenix_repo_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

}
