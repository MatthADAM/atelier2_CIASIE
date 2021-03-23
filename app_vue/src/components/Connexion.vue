<template>
    <div>
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
</template>

<script>
import {urlApi} from '../variables/variables.js';
    export default {
    data () {
        return {
            email:null,
            pwd:null,
            test:"sha1$8cdb9019$1$31d4baf37ba314e7772ba625bd1567557e4e08b4",
        }
    },
    methods: {
        connexion () { 
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            let emailValid = re.test(String(this.email).toLowerCase());

            if (emailValid == false) {
                alert("Rentrez un email valide");
            } else {
                let passwordHash = require('password-hash');
                if (passwordHash.verify(this.pwd, this.test)) {
                    alert("Connexion OK");
                    localStorage.setItem('connected',true);
                    localStorage.setItem('name', this.email);
                    this.$router.push('/events');
                } else {
                    alert("Bad password or email");
                }
            }
        },
    },
        
    }
</script>

<style>

</style>