import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui'
import store from './store'
import 'element-ui/lib/theme-chalk/index.css'
//导入全局样式表
import './assets/css/global.css'
//引入字体图标库
import './assets/iconfont/iconfont.css'
//图片预览功能
import preview from 'vue-photo-preview'
import 'vue-photo-preview/dist/skin.css'
let options = {
  fullscreenEl: false
};
//音乐播放器功能
import vueAplayer from 'vue-aplayer'

Vue.use(vueAplayer)
Vue.use(preview, options)
Vue.use(preview)
Vue.use(ElementUI)

//引入axios
import axios from 'axios'

let BASE_URL = 'http://localhost:4000/'
// let BASE_URL = 'http://8.129.128.30:4000/'
//配置请求的根路径
axios.defaults.baseURL = BASE_URL
//给请求头中添加token
axios.interceptors.request.use(config => {
  config.headers.Authorization = window.sessionStorage.getItem('token') || null
  return config
})

Vue.prototype.$http = axios
Vue.prototype.$apiServer = BASE_URL
Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')