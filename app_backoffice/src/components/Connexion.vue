<template>
    <div class="form">
        <p>Bienvenue</p>
        <div class="form-connect shadow p-3 mb-5 bg-white rounded">
            <form>
                <div class="form-group">
                    <label for="email">Adresse mail</label>
                    <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Entrez votre adresse mail" v-model="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" class="form-control" id="password" placeholder="Mot de passe" v-model="pwd" required>
                    <small id="emailHelp" class="form-text text-muted">Ce mot de passe est personnel, ne le partagez pas</small>
                </div>
                <button type="submit" class="btn btn-primary" v-on:click="connexion">Connexion</button>
            </form>
        </div>
    </div>
</template>

<script>
import $ from 'jquery';
import sha256 from 'sha256'
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
                    url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/userAdmin/" + this.email,
                    success: function (result) {
                        res = result[0].password;
                        name = result[0].Name;
                if (sha256(pass) == res) {
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