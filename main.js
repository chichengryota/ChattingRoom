import Vue from 'vue'
import App from './App'
import store from './store'
import {http,BASE_URL} from 'static/js/request.js'
import commonJs from 'static/js/common.js'
import uView from "uview-ui";
Vue.use(uView);

Vue.config.productionTip = false

// 添加域名
Vue.prototype.$apiServer = BASE_URL

// 封装request请求挂载到全局
Vue.prototype.$http = http;
Vue.prototype.$chat = commonJs;
Vue.prototype.$store = store;

App.mpType = 'app'

const app = new Vue({
	...App
})
app.$mount()
