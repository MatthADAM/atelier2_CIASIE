<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <h3>Profile</h3>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <form>
                </form>
                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" class="form-control" id="login" placeholder="Enter login" v-model="login">
                    </div>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" v-model="name">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd">
                    </div>
                    <div class="form-group">
                        <label for="passwordConfirm">Password confirm</label>
                        <input type="password" class="form-control" id="passwordConfirm" placeholder="Password confirm" v-model="pwdConfirm">
                    </div>
                    <button class="btn btn-primary" v-on:click="updateUser">Update</button>
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
                if (this.login == this.ancLogin && this.name == this.ancName && this.pwd == "" && this.pwdConfirm == "") {
                    alert("Rien n'a changé");
                } else if (this.login != this.ancLogin || this.name != this.ancName || (this.pwd == this.pwdConfirm && this.pwd != "")) {
                    axios.post("http://docketu.iutnc.univ-lorraine.fr:11501/api/updateUser", {
                        loginAnc:this.ancLogin,
                        login:this.login,
                        displayName:this.name ,
                        pwd: this.pwdApi,
                    })
                    .then(function (response) {
                        console.log(response);
                        alert("Updated");
                        sess.set("log",log);
                        sess.set("name",name);
                    });
                    /* $.ajax({
                        type: "POST",
                        url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/updateUser",
                        dataType: "json",
                        success: function (msg) {
                            if (msg) {
                                alert("Somebody was added in list !");
                                location.reload(true);
                            } else {
                                alert("Cannot add to list !");
                            }
                        },

                        data: {
                            loginAnc:this.ancLogin,
                            login:this.login,
                            displayName:this.name ,
                            pwd: passwordHash.generate(this.pwd),
                        }
                    }); */
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
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + this.$session.get("log"),
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