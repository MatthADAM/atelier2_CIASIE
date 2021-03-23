<template>
    <div>
        <p>Inscription</p>
        <div class="form-connect shadow p-3 mb-5 bg-white rounded">
            <form>     
            <div class="form-group">
                    <label for="email">Email address</label>
                    <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email" v-model="email" required>
                    <small id="emailHelp" class="form-text text-muted">This email is personnal don't share it</small>
                </div>
                <div class="form-group">
                    <label for="emailConfirm">Email confirm</label>
                    <input type="email" class="form-control" id="emailConfirm" aria-describedby="emailHelp" placeholder="Confirm email" v-model="emailConfirm" required>
                </div>
                <div class="form-group">
                    <label for="nameDisplay">Name display</label>
                    <input type="text" class="form-control" id="nameDisplay" placeholder="Name display" v-model="nameDisplay" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd" required>
                </div>
                <div class="form-group">
                    <label for="passwordConfirm">Password confirm</label>
                    <input type="password" class="form-control" id="passwordConfirm" placeholder="Password confirm" v-model="pwdConfirm" required>
                </div>
                <button class="btn btn-primary" v-on:click="inscription">Inscription</button>
                <router-link to="/connexion">Connexion</router-link>
            </form>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import {urlApi} from '../variables/variables.js';
    export default {
    data () {
        return {
            email:null,
            emailConfirm:null,
            pwd:null,
            pwdConfirm:null,
            nameDisplay:null,
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
            } else if (this.pwd == null || this.pwdConfirm == null) {
                alert("Renseignez les deux champs mot de passe");
            } else if (this.pwd != this.pwdConfirm) {
                alert("Mots de passes différents");
            } else {
                let passwordHash = require('password-hash');
                this.pwd = passwordHash.generate(this.pwd);
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/inscription', {
                    login: this.email,
                    displayName: this.nameDisplay,
                    pwd: this.pwd,
                })
                .then(function (response) {
                    console.log(response);
                });
            }
        },
    },
        
    }
</script>

<style>

</style>