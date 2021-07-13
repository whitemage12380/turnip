import Vue from 'vue/dist/vue.esm.js';
import Axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, Axios)

// document.addEventListener('turbolinks:load', () => {
//   const element = document.getElementById('app');
//   if (element != null) {
//     const app = new Vue({}).$mount(element);
//     console.log("Loaded Vue", app);
//   }
// });

Vue.component('settlements', {
  data: function () {
    return {
      message: 'WTF'
    }
  },
  template: '<div>{{message}}</div>'
})

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('app');
  if (element != null) {
    const app = new Vue({}).$mount(element);
    console.log("Loaded Vue", app);
  }
});