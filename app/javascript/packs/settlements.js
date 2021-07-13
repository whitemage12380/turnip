// import Vue from 'vue'

// Vue.component("settlements", Settlements)


import Vue from 'vue/dist/vue.esm.js';
import Axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, Axios)

import Settlements from '../settlements.vue'
Vue.component("settlements", Settlements)

// Vue.component('settlements', {
//   data: function () {
//     return {
//       message: 'WTF'
//     }
//   },
//   template: '<div>{{message}}</div>'
// })

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('app');
  if (element != null) {
    const app = new Vue({}).$mount(element);
    console.log("Loaded Vue (settlements)", app);
  }
});

