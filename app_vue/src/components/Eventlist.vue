<template>
    <div>
        <navbar></navbar>
        <h3>Liste d'événements</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th v-bind:class="order === 1 ? 'descending' : 'ascending'" class="clickable" v-on:click="order = order * - 1" scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date</th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="item in filterOwner" :key="item.name">
                <td>{{item.owner}}</td>
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
import $ from 'jquery'
    export default {
        methods: {
        },
        computed: {
            filterOwner() {
                var part1;
                var part2;
                if (this.order == 1) {
                    part1 = this.res.filter(log => log.owner == this.$session.get("log"));
                    part2 = this.res.filter(log => log.owner != this.$session.get("log"));
                } else {
                    part1 = this.res.filter(log => log.owner != this.$session.get("log"));
                    part2 = this.res.filter(log => log.owner == this.$session.get("log"));
                }
                this.res = part1;
                part2.forEach(element => {
                    this.res.push(element);
                });
                console.log(this.res);
                return this.res;
            }
        },
        data () {
            return {
                res: [],
                order: -1,
            }
        },
        created () {
            var tab = [];
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1",
                success: function (result) {
                    tab = result;
                },
                async: false
            });
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"),
                success: function (result) {
                    result.forEach(element => {
                        tab.push(element);
                    });
                },
                async: false
            });
            this.res = tab;
        },
        components: { Navbar,},
    }
</script>

<style >
.clickable:hover {
    cursor:pointer;
}
.ascending:after {
    content: "\25B2";
    padding-left: 15px;
}
.descending:after {
    content: "\25BC";
    padding-left: 15px;
}
</style>