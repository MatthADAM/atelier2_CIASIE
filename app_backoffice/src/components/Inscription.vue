<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <p>Créer un compte</p>
            <p>Attention ! Ce compte aura les permissions d'administrations.</p>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <form>     
                <div class="form-group">
                        <label for="email">Adresse mail</label>
                        <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Adresse mail" v-model="email" required>
                    </div>
                    <div class="form-group">
                        <label for="emailConfirm">Confirmation de l'adresse mail</label>
                        <input type="email" class="form-control" id="emailConfirm" aria-describedby="emailHelp" placeholder="Confirmer adresse mail" v-model="emailConfirm" required>
                    </div>
                    <div class="form-group">
                        <label for="nameDisplay">Nom</label>
                        <input type="text" class="form-control" id="nameDisplay" placeholder="Nom" v-model="nameDisplay" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mot de passe</label>
                        <input type="password" class="form-control" id="password" placeholder="Mot de passe" v-model="pwd" required>
                        <small id="emailHelp" class="form-text text-muted">Ce mot de passe est personnel, ne le partagez pas</small>
                    </div>
                    <div class="form-group">
                        <label for="passwordConfirm">Confirmation du mot de passe</label>
                        <input type="password" class="form-control" id="passwordConfirm" placeholder="Confirmer mot de passe" v-model="pwdConfirm" required>
                    </div>
                    <button class="btn btn-primary" v-on:click="inscription">Créer compte</button>
                </form>
            </div>
        </div>
    </div> 
</template>

<script>
import axios from 'axios';
import Navbar from './Navbar.vue'
import {urlApi} from '../variables/variables.js';
import sha256 from 'sha256'
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
            var rout = this.$router;
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
                this.pwd = sha256(this.pwd);
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/inscription', {
                    login: this.email,
                    displayName: this.nameDisplay,
                    pwd: this.pwd,
                })
                .then(function (response) {
                    rout.push("/map");
                });
            }
        },
    },
    components: { Navbar,},
        
    }
</script>

<style>

</style>