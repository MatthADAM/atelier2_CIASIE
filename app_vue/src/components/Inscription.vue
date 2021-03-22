<template>
    <div class="form-connect shadow p-3 mb-5 bg-white rounded">
        <p>Inscription</p>
        <form>
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email" v-model="email" required>
                <small id="emailHelp" class="form-text text-muted">This email is personnal don't share it</small>
            </div>
            <div class="form-group">
                <label for="emailConfirm">Email address</label>
                <input type="email" class="form-control" id="emailConfirm" aria-describedby="emailHelp" placeholder="Confirm email" v-model="emailConfirm" required>
                <small id="emailHelp" class="form-text text-muted">This email is personnal don't share it</small>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd" required>
            </div>
            <button type="submit" class="btn btn-primary" v-on:click="inscription">Inscription</button>
            <router-link to="/connexion">Connexion</router-link>
        </form>
    </div>
</template>

<script>
    export default {
    data () {
        return {
            email:null,
            emailConfirm:null,
            pwd:null,
        }
    },
    methods: {
        inscription () {
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            let emailValid = re.test(String(this.email).toLowerCase());
            let emailConfValid = re.test(String(this.emailConfirm).toLowerCase());

            if (this.email == null || this.emailConfirm == null) {
                alert("Renseignez les deux champs email");
            } else if (emailValid == false || emailConfValid == false) {
                alert("Rentrez un email valide");
            } else if (this.email != this.emailConfirm) {
                alert("Email different");
            } else {
                alert("TODO");
            }
        },
    },
        
    }
</script>

<style>

</style>