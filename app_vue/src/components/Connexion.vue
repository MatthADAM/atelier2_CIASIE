<template>
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
</template>

<script>
import $ from 'jquery';
export default {
    data () {
        return {
            email:null,
            pwd:null,
            res:"",
        }
    },
    methods: {
        connexion () { 
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            let emailValid = re.test(String(this.email).toLowerCase());
            var pass = this.pwd
            var sess = this.$session;
            var rout = this.$router;
            var res;
            var name;
            var email = this.email;

            if (emailValid == false) {
                alert("Rentrez un email valide");
            } else {
                $.ajax({
                    url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + this.email,
                    success: function (result) {
                        res = result[0].password;
                        name = result[0].Name;
                        let passwordHash = require('password-hash');
                if (passwordHash.verify(pass, res)) {
                    sess.start()
                    sess.set("name",name);
                    sess.set("log",email);
                    rout.push('/map');
                } else {
                    alert("Bad password or email");
                }
                    },
                    async: false
                });
                
            }
        },
    },    
}
</script>

<style>

</style>