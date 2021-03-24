<template>
    <div>
        <navbar></navbar>
        <h3>Liste d'événements</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Name</th>
                <th scope="col">Adress</th>
                <th scope="col">PostCode</th>
                <th scope="col">Date</th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="item in res" :key="item.name">
                <td>{{item.name}}</td>
                <td>{{item.adress}}</td>
                <td>{{item.postCode}}</td>
                <td>{{item.date}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import axios from 'axios'
    export default {
        data () {
            return {
                res: [],
            }
        },
        created () {
            axios
            .get("http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1")
            .then(response => {
                this.res = response.data;
            });
            axios
            .get("http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"))
            .then(response => {
                response.data.forEach(element => {
                    this.res.push(element);
                });
            });
        },
        components: { Navbar,},
    }
</script>

<style >

</style>