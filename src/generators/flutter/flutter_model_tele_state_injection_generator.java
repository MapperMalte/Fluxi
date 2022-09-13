package generators.flutter;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import core.FluxiBag;

@MovedTo(path = "#FLUTTER_ROOT/lib/fluxi/")
public class flutter_model_tele_state_injection_generator
{
    FluxiBag fluxiBag;

    public flutter_model_tele_state_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }

}
