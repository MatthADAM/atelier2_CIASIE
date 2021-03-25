<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <p>Welcome</p>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <form>
                    <div class="form-group">
                        <label for="email">Email address</label>
                        <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email" v-model="email" required>
                        <small id="emailHelp" class="form-text text-muted">This email is personnal don't share it</small>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd" required>
                    </div>
                    <button type="submit" class="btn btn-primary" v-on:click="connexion">Connexion</button>
                    <router-link to="/inscription">Inscription</router-link>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
    export default {
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        components: {Navbar},
    }
</script>

<style >

</style>