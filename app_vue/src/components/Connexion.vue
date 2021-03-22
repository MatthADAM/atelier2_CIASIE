<template>
    <div class="form-connect shadow p-3 mb-5 bg-white rounded">
        <p>Welcome</p>
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
</template>

<script>
    export default {
    data () {
        return {
            email:null,
            pwd:null,
        }
    },
    methods: {
        connexion () { 
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            let emailValid = re.test(String(this.email).toLowerCase());

            if (emailValid == false) {
                alert("Rentrez un email valide");
            } else {
                alert("TODO");
            }
        },
    },
        
    }
</script>

<style>

</style>