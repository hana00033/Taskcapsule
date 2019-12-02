import Vue from 'vue/dist/vue.esm.js'
import Router from './router/router'
import Header from './components/header.vue'

import VCalendar from 'v-calendar';
Vue.use(VCalendar);
Vue.config.productionTip = false;


var app = new Vue({
  el: '#app',
  router: Router,
  components:{
      'navbar':Header,
  }
});