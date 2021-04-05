import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    joinRoom: {},
    leaveRoom: {},
    avatar: ''
  },
  mutations: {
    setJoinRoom(state, payload) {
      state.joinRoom.username = payload.username
    },
    setLeaveRoom(state, payload) {
      state.leaveRoom.username = payload.username
    },
    setAvatar(state, payload) {
      state.avatar = payload
    }
  },
  actions: {},
  modules: {}
})