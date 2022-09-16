package generators.vuejs;

import annotations.MovedTo;
import core.FluxiBag;

@MovedTo(path = "#ELIXIR_ROOT/lib/#nAME")
public class vuejs_store_injection_generator
{
    FluxiBag fluxiBag;

    public vuejs_store_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

}
