import Vue from 'vue';

import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
Vue.use(Vuetify)

import Axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, Axios)

import Settlements from '../components/settlements/settlements.vue'
Vue.component("settlements", Settlements)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('app');
  if (element != null) {
    const app = new Vue({vuetify: new Vuetify()}).$mount(element);
    console.log("Loaded Vue (settlements)", app);
  }
});

