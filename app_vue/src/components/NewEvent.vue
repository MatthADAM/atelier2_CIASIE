<template>
    <div>
        <navbar></navbar>
        <div class="form">
            <h3>Nouvel event</h3>
            <div class="form-connect shadow p-3 mb-5 bg-white rounded">
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
                    <br/>
                    <!-- <input type="number" min="0" max="1" class="form-control" id="public" v-model="publicEvent" required> -->
                    <input type="radio" id="oui" name="pub" value=1 v-model="publicEvent">
                    <label for="oui">Public</label>
                    <input type="radio" id="non" name="pub" value=0 v-model="publicEvent">
                    <label for="non">Prive</label>
                </div>
                <div>
                    <label for="date">Date of event</label>
                    <input type="datetime-local" class="form-control" id="date" v-model="date" required>
                </div>
                <button type="submit" class="btn btn-primary" v-on:click="createEvent">Créer</button>
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
                publicEvent:0,
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
                var rout = this.$router;
                axios.post("https://docketu.iutnc.univ-lorraine.fr:11501/api/addEvent", {
                    owner:this.$session.get("log"),
                    name :this.name,
                    adress:this.adress,
                    postCode:this.postCode,
                    public: this.publicEvent,
                    date: this.date,
                })
                .then(function (response) {
                    rout.push('/myevents');
                });
            }
        },
    }
</script>

<style >

</style>