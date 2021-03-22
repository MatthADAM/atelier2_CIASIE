<template>
    <div>
        <img class="icon" src="../assets/meeting.png">
        <p>Bienvenue !</p>
        <router-link to="/connexion" tag="button" class="btn btn-outline-primary"> Se connecter </router-link>
        <router-link to="/inscription" tag="button" class="btn btn-outline-info"> S'inscrire </router-link>
    </div>
</template>

<script>
    export default {
        
    }
</script>

<style>
.icon {
    height:10rem;
    width:auto;
}
</style>