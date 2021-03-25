import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import VueSession from 'vue-session'
import VModal from 'vue-js-modal'

Vue.use(VueSession)
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(VModal)

import HomePage from './components/Homepage.vue'
import Connexion from './components/Connexion.vue'
import Inscription from './components/Inscription.vue'
import Map from './components/Map.vue'
import EventList from './components/Eventlist.vue'
import MyEvents from './components/Myevents.vue'
import Profile from './components/Profile.vue'
import NotFound from './components/Notfound.vue'
import NewEvent from './components/NewEvent.vue'

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  
  routes : [
    {path: '/', component :HomePage},
    {path: '/connexion', component :Connexion},
    {path: '/inscription', component :Inscription},
    {path: '/map', component :Map},
    {path: '/list', component :EventList},
    {path: '/myevents', component :MyEvents},
    {path: '/profile', component :Profile},
    {path: '/newevent', component :NewEvent},
    {path: '*', component :NotFound},//Path * TJRS a la fin /!\
  ],
});

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
