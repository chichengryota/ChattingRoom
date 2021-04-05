import Vue from 'vue'
import Router from 'vue-router'
import {
  Message
} from 'element-ui';

import Home from '../views/Home.vue'
import Login from '../components/Login.vue'
import Register from '../components/Register.vue'
import HomeMain from '../components/HomeMain.vue'
import UserInfo from '../components/UserInfo.vue'
import MyInfo from '../components/UserInfo/MyInfo.vue'
import Account from '../components/UserInfo/Account.vue'
import MyMessage from '../components/UserInfo/MyMessage.vue'
import Dynamic from '../components/Dynamic.vue'
import Chatting from '../components/Chatting.vue'
import MusicRoom from '../components/MusicRoom.vue'
import Music from '../components/MusicPhoto/Music.vue'
import Scenery from '../components/MusicPhoto/Scenery.vue'
import Cartoon from '../components/MusicPhoto/Cartoon.vue'
import Beauty from '../components/MusicPhoto/Beauty.vue'
import Pets from '../components/MusicPhoto/Pets.vue'

//解决vue重复点击路由报错
const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(Router)

const routes = [{
    path: '/',
    component: Home,
    meta: {
      requireAuth: false
    },
    children: [{
        path: '/',
        meta: {
          requireAuth: false
        },
        component: HomeMain
      }, {
        path: '/userinfo',
        component: UserInfo,
        meta: {
          requireAuth: true
        },
        children: [{
          path: '/userinfo/1',
          component: MyInfo,
          meta: {
            requireAuth: true
          },
        }, {
          path: '/userinfo/2',
          component: Account,
          meta: {
            requireAuth: true
          },
        }, {
          path: '/userinfo/3',
          component: MyMessage,
          meta: {
            requireAuth: true
          },
        }]
      }, {
        path: '/dynamic',
        component: Dynamic,
        meta: {
          requireAuth: false
        }
      }, {
        path: '/chatting',
        component: Chatting,
        meta: {
          requireAuth: true
        }
      }, {
        path: '/find',
        component: MusicRoom,
        meta: {
          requireAuth: false
        }
      },
      {
        path: '/music',
        component: Music,
        meta: {
          requireAuth: false
        }
      }, {
        path: '/scenery',
        component: Scenery,
        meta: {
          requireAuth: false
        }
      }, {
        path: '/pets',
        component: Pets,
        meta: {
          requireAuth: false
        }
      }, {
        path: '/cartoon',
        component: Cartoon,
        meta: {
          requireAuth: false
        }
      }, {
        path: '/beauty',
        component: Beauty,
        meta: {
          requireAuth: false
        }
      }
    ]
  },
  {
    path: '/login',
    component: Login,
    meta: {
      requireAuth: false
    }
  },
  {
    path: '/register',
    component: Register,
    meta: {
      requireAuth: false
    }
  }
]

const router = new Router({
  routes
})

router.beforeEach((to, form, next) => {
  if (to.path === '/login' || to.path === '/register') return next()
  const tokenStr = window.sessionStorage.getItem('token')
  if (!tokenStr && to.meta.requireAuth) {
    Message.warning('请先登录')
    next('/login')
  } else {
    next()
  }
})

export default router