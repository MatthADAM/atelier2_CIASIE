<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <h3>Profile</h3>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <div class="form-group">
                    <label for="login">Adresse mail</label>
                    <input type="text" class="form-control" id="login" placeholder="Adresse mail" v-model="login">
                </div>
                <div class="form-group">
                    <label for="name">Nom</label>
                    <input type="text" class="form-control" id="name" placeholder="Nom" v-model="name">
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd">
                </div>
                <div class="form-group">
                    <label for="passwordConfirm">Confirmer votre mot de passe</label>
                    <input type="password" class="form-control" id="passwordConfirm" placeholder="Confirmer mot de passe" v-model="pwdConfirm">
                </div>
                <button class="btn btn-primary" v-on:click="updateUser">Mettre à jour</button>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import $ from 'jquery'
import axios from 'axios'
import sha256 from 'sha256'
    export default {
        methods: {
            updateUser() {
                var sess = this.$session;
                var log = this.login;
                var name = this.name;
                var ancLogin = this.ancLogin;
                var ancName = this.ancName;
                var pwd = this.pwd;
                var pwdConfirm = this.pwdConfirm;
                var pwdApi = this.pwdApi;
                if (log == ancLogin && name == ancName && pwd == "" && pwdConfirm == "") {
                    alert("Rien n'a changé");
                } else if (log != ancLogin || name != ancName || (pwd == pwdConfirm && pwd != "")) {
                    if (pwd != "") {
                        pwd = sha256(pwd);
                    } else {
                        pwd = pwdApi;
                    }
                    axios.post("http://docketu.iutnc.univ-lorraine.fr:11501/api/updateUserAdmin", {
                        loginAnc:ancLogin,
                        login:log,
                        displayName:name ,
                        pwd: pwd,
                    })
                    .then(function (response) {
                        sess.set("log",log);
                        sess.set("name",name);
                        ancLogin = log
                        document.location.reload();
                    });
                    this.login = log;
                    this.name = name;
                    this.ancLogin = log;
                    this.ancName = name;
                    this.pwd = pwd;
                    this.pwdConfirm = pwdConfirm;
                    this.pwdApi = pwdConfirm;
                }
            }
        },
        data () {
            return {
                login:"",
                ancLogin:"",
                name:"",
                ancName:"",
                pwd:"",
                pwdApi:"",
                pwdConfirm:'',
            }
        },
        components: { Navbar },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        created () {
            var log;
            var nm;
            var pw;
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/userAdmin/" + this.$session.get("log"),
                success: function (result) {
                    log = result[0].login;
                    nm = result[0].Name;
                    pw = result[0].password;
                },
                async: false
            });
            this.login = log;
            this.ancLogin = log;
            this.ancName = nm;
            this.name = nm;
            this.pwdApi = pw;
        },
    }
</script>

<style >

</style>