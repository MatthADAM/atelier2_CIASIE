<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded">
        <a class="navbar-brand">Menu</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <router-link to="/map">
                    <a class="nav-item nav-link" role="a">Map</a>
                </router-link>
                <router-link to="/list">
                    <a class="nav-item nav-link" role="a">Event list</a>
                </router-link>
                <router-link to="/myevents">
                    <a class="nav-item nav-link" role="a">My Events</a>
                </router-link>
                <router-link to="/profile">
                    <a class="nav-item nav-link" role="a">Profile</a>
                </router-link>
                <router-link to="/newevent">
                    <a class="nav-item nav-link" role="a">New Event</a>
                </router-link>
            </div>
        </div>
        <router-link to="/">
            <button type="submit" class="btn btn-outline-danger" v-on:click="logout">Logout</button>
        </router-link>
    </nav>
</template>

<script>
export default {
  data () {
    return {
        name:"",
        adress:"",
        postCode:null,
        publicEvent:0,
        date:null,
        token:"tokenTest",
    }
  },
  methods: {
      logout() {
        this.$session.destroy();
      }
  },

}
</script>

<style>
body {
    background: none;
}
</style>