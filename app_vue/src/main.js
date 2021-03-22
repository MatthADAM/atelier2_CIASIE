import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import HomePage from './components/Homepage.vue'
import Connexion from './components/Connexion.vue'
import Inscription from './components/Inscription.vue'
import NotFound from './components/Notfound.vue'

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  
  routes : [
    {path: '/', component :HomePage},
    {path: '/connexion', component :Connexion},
    {path: '/inscription', component :Inscription},
    {path: '*', component :NotFound},//Path * TJRS a la fin /!\
  ],
});

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
