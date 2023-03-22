<template>
    <div>
        <div>
            <v-data-table
                    :headers="headers"
                    :items="corporate_event_list"
                    class="elevation-11"
                    style="margin-top: 60px;
                    margin-left: 25px;
                    padding-top: 5px;
                    border-top-left-radius: 16px;
                    border-top-right-radius: 16px;
                    margin-right: 25px;"
            >
            <template v-slot:top>
                    <v-text-field
                            v-model="filterStr"
                            label="Suche"
                            class="mx-4"
                    ></v-text-field>
                </template>

                <template v-slot:item.actions="{item }">
                    <v-dialog
                v-model="editing_person_like"
                scrollable
                max-width="600px"
                >
                <template v-slot:activator="{ on, attrs }">
                    <v-btn
                        color="blue-grey"
                        class="ma-2 white--text"
                        v-bind="attrs"
                        v-on="on"
                        >
                        <v-icon
                            dark
                            center
                        >
                            mdi-pencil
                        </v-icon>
                    </v-btn>

                </template>
                <v-card style="padding: 25px;">
                    <v-card-title>Veranstaltung bearbeiten</v-card-title>
                    <v-form v-model="valid">
                        <v-container>
#FIELDS_LIST_FOR_EDIT

                        </v-container>
                    </v-form>
                    
                    <v-card-actions>
                        <v-row>
                            <v-spacer>
                            </v-spacer>
                            <v-btn @click="dialog = false" style="padding: 10px;">Erstellen</v-btn>
                            <v-btn @click="dialog = false" style="padding: 10px;">Abbrechen</v-btn>
                        </v-row>
                    </v-card-actions>
                </v-card>
            </v-dialog>
            <v-dialog
              transition="dialog-top-transition"
              max-width="600"
      >
        <template v-slot:activator="{ on, attrs }">
            <span style="bottom: 20px; left: 20px;">
                <v-btn
                        color="blue-grey"
                        class="ma-2 white--text"
                        v-bind="attrs"
                        v-on="on"
                        @click.native="deleting = true"
                        >
                        <v-icon
                            center
                            dark
                        >
                            mdi-delete
                        </v-icon>
                    </v-btn>

      </span>
        </template>
        <template v-slot:default="deleting_corporate_event">
          <v-card>
            <v-toolbar
                    color="primary"
                    dark
            >Willst du die Veranstaltung wirklich löschen?
            </v-toolbar>
            <v-card-text>
              <br>
              Diese Aktion ist <span style="color: red">endgültig</span> und kann nicht zurückgenommen werden.
            </v-card-text>

            <v-card-actions class="justify-space-between">
              <v-btn
                      text
                      @click.native="dialog.value = false"
              >Abbrechen</v-btn>
              <v-btn
                      text
                      @click.native="function() {
                        dialog.value = false;
                        deleteCustomer();
                      }"
              >Löschen</v-btn>

            </v-card-actions>
          </v-card>
        </template>
    </v-dialog>
                    
                </template>
            
        </v-data-table>
            <div style="height: 100px"></div>
        </div>
        <div style="position: fixed;bottom: 20px; right: 15px;">
            <v-dialog
                v-model="creating_person_like"
                scrollable
                max-width="600px"
                >
                <template v-slot:activator="{ on, attrs }">
                    <v-btn
                    class="mx-2"
                    fab
                    dark
                    color=primary
                    v-bind="attrs"
                    v-on="on"
            >

                <v-icon dark>
                    mdi-plus
                </v-icon>
            </v-btn>
                </template>
                <v-card style="padding: 25px;">
                    <v-card-title>Veranstaltung erstellen</v-card-title>
                    <v-form v-model="valid">
                        <v-container>
                    { text: 'Person_like_uuid<v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Ticketpreis"
                                        required
                                ></v-text-field>person_like_uuid' } , 
                    { text: 'Liked_user_uuid<v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Ticketpreis"
                                        required
                                ></v-text-field>liked_user_uuid' } , 
                    { text: 'Liking_user_uuid<v-text-field
                                        v-model="lastname"
                                        :rules="nameRules"
                                        label="Ticketpreis"
                                        required
                                ></v-text-field>liking_user_uuid' } 
                        </v-container>
                    </v-form>
                    <v-btn>Erstellen</v-btn>
                    <v-card-actions>
                    <v-btn
                        color="blue darken-1"
                        text
                        @click="dialog = false"
                    >
                        Close
                    </v-btn>
                    <v-btn
                        color="blue darken-1"
                        text
                        @click="dialog = false"
                    >
                        Save
                    </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </div>
    </div>
</template>

<script>
    export default {
        name: "PersonLikeDataTable",
        components: {

        },
        computed : {
            person_like_list () {
                return [
                {
                    "title": "Bla",
                    "description": "bli",
                    "date": "",
                    "einlass": "",
                    "preis": "1000"
                },
                {
                    "title": "Bla",
                    "description": "bli",
                    "date": "",
                    "einlass": "",
                    "preis": "1000"
                }
                ];
            }
        },
        mounted() {

        },
        data(){
            return {
                creating_person_like: false,
                editing_person_like: false,
                deleting_person_like: false,

                headers: [
                    { text: 'Person_like_uuid', value: 'person_like_uuid' } , 
                    { text: 'Liked_user_uuid', value: 'liked_user_uuid' } , 
                    { text: 'Liking_user_uuid', value: 'liking_user_uuid' } 
                ],
            };
        }
    }
</script>

<style scoped>

</style>



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
        :items="person_like_list"
        :footer-props="{'items-per-page-options':[30,60,90]}"
        item-key="name"
        class="elevation-1">
            <template v-slot:body="{ person_like_list, headers }">
                <tbody>
                    <tr v-for="(person_like,idx,k) in person_like_list" :key="idx">
                        <td v-for="(header,key) in headers" :key="key">
                            <v-edit-dialog
                              :return-value.sync="person_like[header.value]"
                              @save="save"
                              @cancel="cancel"
                              @open="open"
                              @close="close"
                              large
                            > {{person_like[header.value]}}
                              <template v-slot:input>
                                <v-text-field
                                  v-model="person_like[header.value]"
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
        name: "PersonLikeDataTable",
        components: {

        },
        computed : {
            person_like_list : (){
                return $store.state.person_like_list;
            }
        },
        mounted() {

        },
        data(){
            return {
                headers: [
                    { text: 'Person_like_uuid', value: 'person_like_uuid' } , 
                    { text: 'Liked_user_uuid', value: 'liked_user_uuid' } , 
                    { text: 'Liking_user_uuid', value: 'liking_user_uuid' } 
                ],
            };
        }
    }
</script>

<style scoped>

</style>
