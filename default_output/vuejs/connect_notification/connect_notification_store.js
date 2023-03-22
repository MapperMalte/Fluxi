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
    connect_notification_list: [],
  },

  getters : {
    connect_notification_list: state => {
      return state.connect_notification_list;
    },
    getConnectNotificationByUUID: (state) => (uuid) => {
      return state.connect_notification_list.find(connect_notification => connect_notification.connect_notification_uuid === uuid)
    },
  },
  mutations: {
    add_connect_notification: ( state, newValue ) => {
      state.connect_notification_list.push(newValue);
    },
    update_connect_notification: ( state, updatedItem ) => {
        state.connect_notification_list = [...state.categories.map(
            item => item.connect_notification_uuid !== updatedItem.connect_notification_uuid ? item : {...item, ...updatedItem}
        )
        ]
    },
    delete_connect_notification: ( state, updatedItem ) => {
            state.connect_notification_list = [...state.categories.map(
                item => item.connect_notification_uuid !== updatedItem.connect_notification_uuid ? item : {...item, ...updatedItem}
            )
            ]
        },
  },
  actions: {
    connectConnectNotificationSocketInstanceIfNotConnected: ({commit,state}, newValue) => {
      let socket = new Socket(state.base_route);
      socket.connect();
      let channel = socket.channel("connect_notification:lobby", {});
      channel.join()
          .receive("ok", (resp)=> {
            state.live_socket = socket;
            state.connect_notification_list = [];
          })
          .receive("error", resp => {

          });
      channel.on('connect_notification:updated', payload => {
        commit('update_connect_notification', payload)
      });
    },
    sync :({commit,state},ConnectNotification) => {
      channel.push("sync", {
          "connect_notification": ConnectNotification
      });
    },
  },
  modules: {}
})
