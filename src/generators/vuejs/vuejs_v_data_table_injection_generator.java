package generators.vuejs;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import core.FluxiBag;
import misc.CaseTransformer;

@MovedTo(path = "#ELIXIR_ROOT/lib/#nAME")
public class vuejs_v_data_table_injection_generator
{
    FluxiBag fluxiBag;

    public vuejs_v_data_table_injection_generator(FluxiBag fluxiBag)
    {
        this.fluxiBag = fluxiBag;
    }
/*

                    { text: 'Zeitstempel', value: 'timestamp' },
                    { text: 'Mitarbeiter', value: 'mitarbeiter_name' },
                    { text: 'Kunde', value: 'customer_name' },
                    { text: 'Objekt', value: 'objekt_name' },
                    { text: 'Bereich', value: 'bereich' },
                    { text: 'Kontrollpunkt', value: 'kontrollpunkt' },
                    { text: 'Anzahl', value: 'anzahl' },
                    { text: 'Ereignisart', value: 'ereignisart' },
                    { text: 'Bemerkung', value: 'bemerkung' },
 */

    @InjectIntoParam(name = "#HEADERS_FOR_V_DATA_TABLE")
    public String generateHeadersForVDataTable()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("                    { text: '");
            stringBuilder.append(CaseTransformer.firstLetterBig(fluxiBag.params[i].name));
            stringBuilder.append("', value: '");
            stringBuilder.append(fluxiBag.params[i].name);
            stringBuilder.append("' } ");
            if (i < fluxiBag.params.length - 1) {
                stringBuilder.append(", ");
                stringBuilder.append(System.getProperty("line.separator"));
            }
        }
        return stringBuilder.toString();
    }
}
