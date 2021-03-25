<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <p>Welcome</p>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
                <form>
                    <div class="form-group">
                        <label for="name">Name of event</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" v-model="name" required>
                    </div>
                    <div class="form-group">
                        <label for="adress">Adress</label>
                        <input type="text" class="form-control" id="adress" placeholder="Adress of event" v-model="adress" required>
                    </div>
                    <div class="form-group">
                        <label for="postCode">PostCode</label>
                        <input type="number" class="form-control" id="postCode" placeholder="PostCode of event" v-model="postCode" required>
                    </div>
                    <div>
                        <label for="public">Event public</label>
                        <input type="number" min="0" max="1" class="form-control" id="public" v-model="publicEvent" required>
                    </div>
                    <div>
                        <label for="date">Date of event</label>
                        <input type="date" class="form-control" id="date" v-model="date" required>
                    </div>
                    <button type="submit" class="btn btn-primary" v-on:click="createEvent">Créer</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import axios from 'axios'
    export default {
        data () {
            return {
                name:"",
                adress:"",
                postCode:null,
                publicEvent:false,
                date:null,
            }
        },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        components: {Navbar},
        methods: {
            createEvent() {
                axios.post("http://docketu.iutnc.univ-lorraine.fr:11501/api/addEvent", {
                    owner:this.$session.get("log"),
                    name :this.name,
                    adress:this.adress,
                    postCode:this.postCode,
                    public: this.publicEvent,
                    date: this.date,
                    token: "fzefzefzefezfzefez"
                })
                .then(function (response) {
                    console.log(response);
                    alert("Event " + this.name + " créé !");
                });
            }
        },
    }
</script>

<style >

</style>