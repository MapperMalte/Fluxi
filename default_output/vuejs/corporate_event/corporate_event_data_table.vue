<template>
    <div>
        <v-data-table
                :headers="headers"
                :items="events"
                class="elevation-11"
                style="margin-top: 60px;
                margin-left: 25px;
                padding-top: 5px;
                border-top-left-radius: 16px;
                border-top-right-radius: 16px;
                margin-right: 25px;"
        ></v-data-table>
        <div style="height: 100px"></div>
    </div>
    <v-card>
        <v-data-table
        :headers="headers"
        :items="corporate_event_list"
        :footer-props="{'items-per-page-options':[30,60,90]}"
        item-key="name"
        class="elevation-1">
            <template v-slot:body="{ corporate_event_list, headers }">
                <tbody>
                    <tr v-for="(corporate_event,idx,k) in corporate_event_list" :key="idx">
                        <td v-for="(header,key) in headers" :key="key">
                            <v-edit-dialog
                              :return-value.sync="corporate_event[header.value]"
                              @save="save"
                              @cancel="cancel"
                              @open="open"
                              @close="close"
                              large
                            > {{corporate_event[header.value]}}
                              <template v-slot:input>
                                <v-text-field
                                  v-model="corporate_event[header.value]"
                                  label="Edit"
                                  single-line
                                ></v-text-field>
                              </template>
                            </v-edit-dialog>
                        </td>
                    </tr>
                </tbody>
            </template>
        </v-data-table>
    </v-card>
</template>

<script>
    import { Socket} from 'phoenix-socket'
    export default {
        name: "CorporateEventDataTable",
        components: {

        },
        computed : {
            corporate_event_list : (){
                return $store.state.corporate_event_list;
            }
        },
        mounted() {

        },
        data(){
            return {
                headers: [
                    { text: 'Corporate_event_uuid', value: 'corporate_event_uuid' } , 
                    { text: 'Title', value: 'title' } , 
                    { text: 'Description', value: 'description' } , 
                    { text: 'Date', value: 'date' } , 
                    { text: 'Einlass', value: 'einlass' } , 
                    { text: 'Preis', value: 'preis' } 
                ],
            };
        }
    }
</script>

<style scoped>

</style>
