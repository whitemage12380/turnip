import Vue from 'vue';

import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import Vuetify from 'vuetify'
Vue.use(Vuetify)

import Axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, Axios)

import Settlements from '../components/settlements/settlements.vue'
import Settlement from '../components/settlements/settlement.vue'
import SettlementAttribute from '../components/settlements/settlement_attribute.vue'
import SettlementLocation from '../components/settlements/settlement_location.vue'
Vue.component("settlements", Settlements)
Vue.component("settlement", Settlement)
Vue.component("settlement-attribute", SettlementAttribute)
Vue.component("settlement-location", SettlementLocation)

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('app');
  if (element != null) {
    const app = new Vue({vuetify: new Vuetify()}).$mount(element);
    console.log("Loaded Vue (settlements)", app);
  }
});

