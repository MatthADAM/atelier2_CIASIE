<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <h3>Profile</h3>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <form>
                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" class="form-control" id="login" placeholder="Enter login" v-model="login" required>
                    </div>
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" v-model="name" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" placeholder="Password" v-model="pwd" required>
                    </div>
                    <div class="form-group">
                        <label for="passwordConfirm">Password confirm</label>
                        <input type="password" class="form-control" id="passwordConfirm" placeholder="Password confirm" v-model="pwdConfirm" required>
                    </div>
                    <button class="btn btn-primary" v-on:click="updateUser">Update</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import $ from 'jquery'
    export default {
        methods: {
            updateUser() {

            }
        },
        data () {
            return {
                login:"",
                ancLogin:"",
                name:"",
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
            this.name = nm;
            this.pwdApi = pw;
        },
    }
</script>

<style >

</style>