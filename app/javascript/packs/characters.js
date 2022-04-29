import Vue from 'vue';

import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import Vuetify from 'vuetify'
Vue.use(Vuetify)

import Characters from '../components/characters/characters.vue'
Vue.component("characters", Characters)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('app');
  if (element != null) {
    const app = new Vue({vuetify: new Vuetify({icons: {iconfont: 'mdiSvg'}})}).$mount(element);
    console.log("Loaded Vue (characters)", app);
  }
});

