import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import VueAxios from 'vue-axios'
import {Socket} from "phoenix-socket";

Vue.use(Vuex);
Vue.use(VueAxios, axios);

export default new Vuex.Store({
  state: {
    base_route: "http://localhost:4000/api",
    live_socket: null,
    connected: false,
    corporate_event_list: [],
  },

  getters : {
    corporate_event_list: state => {
      return state.corporate_event_list;
    },
    getCorporateEventByUUID: (state) => (uuid) => {
      return state.corporate_event_list.find(corporate_event => corporate_event.corporate_event_uuid === uuid)
    },
  },
  mutations: {
    add_corporate_event: ( state, newValue ) => {
      state.corporate_event_list.push(newValue);
    },
    update_corporate_event: ( state, updatedItem ) => {
        state.corporate_event_list = [...state.categories.map(
            item => item.corporate_event_uuid !== updatedItem.corporate_event_uuid ? item : {...item, ...updatedItem}
        )
        ]
    },
    delete_corporate_event: ( state, updatedItem ) => {
            state.corporate_event_list = [...state.categories.map(
                item => item.corporate_event_uuid !== updatedItem.corporate_event_uuid ? item : {...item, ...updatedItem}
            )
            ]
        },
  },
  actions: {
    connectCorporateEventSocketInstanceIfNotConnected: ({commit,state}, newValue) => {
      let socket = new Socket(state.base_route);
      socket.connect();
      let channel = socket.channel("corporate_event:lobby", {});
      channel.join()
          .receive("ok", (resp)=> {
            state.live_socket = socket;
            state.corporate_event_list = [];
          })
          .receive("error", resp => {

          });
      channel.on('corporate_event:updated', payload => {
        commit('update_corporate_event', payload)
      });
    },
    sync :({commit,state},CorporateEvent) => {
      channel.push("sync", {
          "corporate_event": CorporateEvent
      });
    },
  },
  modules: {}
})
