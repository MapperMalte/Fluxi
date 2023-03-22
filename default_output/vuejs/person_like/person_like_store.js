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
    person_like_list: [],
  },

  getters : {
    person_like_list: state => {
      return state.person_like_list;
    },
    getPersonLikeByUUID: (state) => (uuid) => {
      return state.person_like_list.find(person_like => person_like.person_like_uuid === uuid)
    },
  },
  mutations: {
    add_person_like: ( state, newValue ) => {
      state.person_like_list.push(newValue);
    },
    update_person_like: ( state, updatedItem ) => {
        state.person_like_list = [...state.categories.map(
            item => item.person_like_uuid !== updatedItem.person_like_uuid ? item : {...item, ...updatedItem}
        )
        ]
    },
    delete_person_like: ( state, updatedItem ) => {
            state.person_like_list = [...state.categories.map(
                item => item.person_like_uuid !== updatedItem.person_like_uuid ? item : {...item, ...updatedItem}
            )
            ]
        },
  },
  actions: {
    connectPersonLikeSocketInstanceIfNotConnected: ({commit,state}, newValue) => {
      let socket = new Socket(state.base_route);
      socket.connect();
      let channel = socket.channel("person_like:lobby", {});
      channel.join()
          .receive("ok", (resp)=> {
            state.live_socket = socket;
            state.person_like_list = [];
          })
          .receive("error", resp => {

          });
      channel.on('person_like:updated', payload => {
        commit('update_person_like', payload)
      });
    },
    sync :({commit,state},PersonLike) => {
      channel.push("sync", {
          "person_like": PersonLike
      });
    },
  },
  modules: {}
})
