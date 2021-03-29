<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Liste d'événements</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date/Heure</th>
                <th scope="col">Status</th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="(item,index) in filterOwner" :key="index">
                <td>{{item.owner}}</td>
                <td>{{item.name}}</td>
                <td>{{item.adress}}</td>
                <td>{{item.postCode}}</td>
                <td>{{item.date}}</td>
                <div v-if="ifInvite(item)">
                    <td v-if="item.accept == 0"><button type="button" @click="acceptEvent(item)" class="btn btn-success">Accepter</button></td>
                    <td v-else><button type="button" @click="refuseEvent(item)" class="btn btn-outline-success">Acceptée</button></td>
                </div>
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
import axios from 'axios'
    export default {
        methods: {
            nextPage() {
                if((this.currentPage*this.pageSize) < this.res.length) this.currentPage++;
            },
            prevPage() {
                if(this.currentPage > 1) this.currentPage--;
            },
            ifInvite(event) {
                if (event.invite) {
                    return true;
                } else {
                    return false;
                }
            },
            acceptEvent(event) {
                axios.post("http://docketu.iutnc.univ-lorraine.fr:11501/api/updatestatus", {
                    event: event.id,
                    user: this.$session.get("log"),
                    status: 1,
                })
                .then(function (response) {
                    document.location.reload();
                });
            },
            refuseEvent(event) {
                axios.post("http://docketu.iutnc.univ-lorraine.fr:11501/api/updatestatus", {
                    event: event.id,
                    user: this.$session.get("log"),
                    status: 0,
                })
                .then(function (response) {
                    document.location.reload();
                });
            },
        },
        computed: {
            filterOwner() {
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
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/invitation/user/" + this.$session.get("log"),
                success: function (result) {
                    result.forEach(element => {
                        invitTab.push(element);
                    });
                },
                async: false
            });
            invitTab.forEach(element => {
                $.ajax({
                    url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/" + element.event,
                    success: function (result) {
                        Object.defineProperty(result[0],"invite", {value: true});
                        Object.defineProperty(result[0],"accept", {value: element.status});
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
</style>