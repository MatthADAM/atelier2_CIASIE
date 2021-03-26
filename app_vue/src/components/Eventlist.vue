<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Liste d'événements</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th v-bind:class="order === 1 ? 'descending' : 'ascending'" class="clickable" v-on:click="order = order * - 1" scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date/Heure</th>
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
        <button @click="prevPage" class="btn btn-primary">Previous page</button> 
        <button @click="nextPage" class="btn btn-primary">Next page</button>
    </div>
</template>

<script>
import Navbar from './Navbar.vue'
import $ from 'jquery'
    export default {
        methods: {
            nextPage() {
                if((this.currentPage*this.pageSize) < this.res.length) this.currentPage++;
            },
            prevPage() {
                if(this.currentPage > 1) this.currentPage--;
            },
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
                return this.res.filter((row, index) => {
		            let start = (this.currentPage-1)*this.pageSize;
		            let end = this.currentPage*this.pageSize;
		            if(index >= start && index < end) return true;
	            });
            }
        },
        data () {
            return {
                res: [],
                order: -1,
                pageSize:10,
                currentPage:1,
            }
        },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        created () {
            var tab = [];
            var invitTab = [];
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1&owner=" + this.$session.get("log"),
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
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/invitation/user/" + this.$session.get("log"),
                success: function (result) {
                    result.forEach(element => {
                        invitTab.push(element.event);
                    });
                },
                async: false
            });
            invitTab.forEach(element => {
                $.ajax({
                    url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/" + element,
                    success: function (result) {
                        tab.push(result[0]);
                    },
                    async: false
                });
            });
            this.res = tab;
            this.res.forEach(element => {
                let annee = element.date.substr(0,4);
                let mois = element.date.substr(5,2);
                let jour = element.date.substr(8,2);
                let heure = element.date.substr(11,2);
                let minute = element.date.substr(14,2);
                element.date = jour + "/" + mois + "/" + annee + " : " + heure + "H" + minute;
            });
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