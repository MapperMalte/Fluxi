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
    story_lobby_list: [],
  },

  getters : {
    story_lobby_list: state => {
      return state.story_lobby_list;
    },
    getStory_lobbyByUUID: (state) => (uuid) => {
      return state.story_lobby_list.find(story_lobby => story_lobby.story_lobby_uuid === uuid)
    },
  },
  mutations: {
    add_story_lobby: ( state, newValue ) => {
      state.story_lobby_list.push(newValue);
    },
    update_story_lobby: ( state, updatedItem ) => {
        state.story_lobby_list = [...state.categories.map(
            item => item.story_lobby_uuid !== updatedItem.story_lobby_uuid ? item : {...item, ...updatedItem}
        )
        ]
    },
    delete_story_lobby: ( state, updatedItem ) => {
            state.story_lobby_list = [...state.categories.map(
                item => item.story_lobby_uuid !== updatedItem.story_lobby_uuid ? item : {...item, ...updatedItem}
            )
            ]
        },
  },
  actions: {
    connectStory_lobbySocketInstanceIfNotConnected: ({commit,state}, newValue) => {
      let socket = new Socket(state.base_route);
      socket.connect();
      let channel = socket.channel("story_lobby:lobby", {});
      channel.join()
          .receive("ok", (resp)=> {
            state.live_socket = socket;
            state.story_lobby_list = [];
          })
          .receive("error", resp => {

          });
      channel.on('story_lobby:updated', payload => {
        commit('update_story_lobby', payload)
      });
    },
    sync :({commit,state},Story_lobby) => {
      channel.push("sync", {
          "story_lobby": Story_lobby
      });
    },
  },
  modules: {}
})
