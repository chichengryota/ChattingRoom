import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../components/Login.vue'
import Register from '../components/Register.vue'
import HomeMain from '../components/HomeMain.vue'
import UserInfo from '../components/UserInfo.vue'
import MyInfo from '../components/UserInfo/MyInfo.vue'
import Account from '../components/UserInfo/Account.vue'
import MyMessage from '../components/UserInfo/MyMessage.vue'
import Message from '../components/Message.vue'
import Chatting from '../components/Chatting.vue'

//解决vue重复点击路由报错
const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(Router)

const routes = [{
    path: '/',
    component: Home,
    children: [{
        path: '/',
        component: HomeMain
      }, {
        path: '/userinfo',
        component: UserInfo,
        children: [{
          path: '/userinfo/1',
          component: MyInfo
        }, {
          path: '/userinfo/2',
          component: Account
        }, {
          path: '/userinfo/3',
          component: MyMessage
        }]
      }, {
        path: '/message',
        component: Message
      },
      {
        path: '/chatting',
        component: Chatting
      },
    ]
  },
  {
    path: '/login',
    component: Login
  },
  {
    path: '/register',
    component: Register
  }
]

const router = new Router({
  routes
})

export default router