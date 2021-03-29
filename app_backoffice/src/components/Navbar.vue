<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded">
        <a class="navbar-brand">Menu</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <router-link to="/map">
                    <a class="nav-item nav-link" role="a">Carte</a>
                </router-link>
                <router-link to="/list">
                    <a class="nav-item nav-link" role="a">Liste des évenements</a>
                </router-link>
                <router-link to="/ulist">
                    <a class="nav-item nav-link" role="a">Liste des utilisateurs</a>
                </router-link>
                <router-link to="/profile">
                    <a class="nav-item nav-link" role="a">Profil</a>
                </router-link>                
            </div>
        </div>
        <router-link to="/inscription">
            <button class="btn btn-outline-info" role="button">Creer un compte</button>
        </router-link>
        <router-link to="/">
            <button type="submit" class="btn btn-outline-danger" v-on:click="logout">Se déconnecter</button>
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