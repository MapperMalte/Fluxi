package generators.vuejs;

import annotations.InjectIntoParam;
import annotations.MovedTo;
import core.FluxiBag;
import misc.CaseTransformer;

@MovedTo(path = "#VUEJS_ROOT/components/#nAME")
public class vuejs_v_data_table_injection_generator {
    FluxiBag fluxiBag;

    public vuejs_v_data_table_injection_generator(FluxiBag fluxiBag) {
        this.fluxiBag = fluxiBag;
    }

    @InjectIntoParam(name = "HEADERS_FOR_V_DATA_TABLE")
    public String generateHeadersForVDataTable() {
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < fluxiBag.params.length; i++) {
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

    /*
     * <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Titel der Veranstaltung"
                                        required
                                ></v-text-field>
                            </v-row>
                            <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Name des Künstlers"
                                        required
                                ></v-text-field>
                            </v-row>
                            <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Einlass"
                                        required
                                ></v-text-field>
                            </v-row>
                            <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Beginn"
                                        required
                                ></v-text-field>
                            </v-row>
                            <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Anzahl Plätze"
                                        required
                                ></v-text-field>
                            </v-row>
                            <v-row>
                                <v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Ticketpreis"
                                        required
                                ></v-text-field>
                            </v-row>
     */
    @InjectIntoParam(name = "FIELDS_LIST_FOR_CREATE")
    public String generateFieldsListForCreate()
    {
        StringBuilder stringBuilder = new StringBuilder();
        for(int i = 0; i < fluxiBag.params.length; i++ )
        {
            stringBuilder.append("                    { text: '");
            stringBuilder.append(CaseTransformer.firstLetterBig(fluxiBag.params[i].name));
            stringBuilder.append("<v-text-field\n" +
            "                                        v-model=\"lastname\"\n" +
            "                                        :rules=\"nameRules\"\n" +
            "                                        label=\"Ticketpreis\"\n" +
            "                                        required\n" +
            "                                ></v-text-field>");
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
