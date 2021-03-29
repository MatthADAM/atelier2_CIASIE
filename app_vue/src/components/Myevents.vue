<template>
    <div class="corps">
        <navbar></navbar>
        <h3>Mes événements</h3>
        <table class="table table-striped" id="myEventsTable">
            <thead>
            <tr>
                <th scope="col">Créateur</th>
                <th scope="col">Nom</th>
                <th scope="col">Adresse</th>
                <th scope="col">Code Postal</th>
                <th scope="col">Date/Heure</th>
                <th scope="col">Inviter</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <tr scope="row" v-for="(item,index) in filterOwner" :key="index">
                <td>{{item.owner}}</td>
                <td>{{item.name}}</td>
                <td>{{item.adress}}</td>
                <td>{{item.postCode}}</td>
                <td>{{item.date}}</td>
                <td><b-icon-card-text class="clickable" v-b-modal.modal-1 @click="currEvent(item.id)"></b-icon-card-text></td>
                <td><b-icon-trash class="clickable" @click="deleteEvent(item.id)"></b-icon-trash></td>
            </tr>
            </tbody>
        </table>
        <button @click="prevPage" class="btn btn-primary">Previous page</button> 
        <button @click="nextPage" class="btn btn-primary">Next page</button>
        <b-modal ref="modal-1" id="modal-1" title="Inviter une personne" hide-footer>
            <div style="margin-bottom:15px">
                <label for="login">Login de la personne</label>
                <input type="text" class="form-control" id="login" placeholder="Qui voulez-vous inviter ?" v-model="invite">
            </div>
            <button class="btn btn-primary" @click="inviterPersonne">Inviter</button>
        </b-modal>
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
            deleteEvent(id) {
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/delete/event/' + id)
                .then(function (response) {
                });
                this.res.forEach(element => {
                    if (element.id == id) {
                        let i = this.res.indexOf(element);
                        this.res.splice(i,1);
                    }
                });
            },
            currEvent(id) {
                this.currentEvent = id;
            },
            inviterPersonne() {
                var invite = this.invite;
                var rf = this.$refs['modal-1'];
                axios.post('http://docketu.iutnc.univ-lorraine.fr:11501/api/addInvitation', {
                    event: this.currentEvent,
                    user: this.invite,
                })
                .then(function (response) {
                    rf.hide();
                    invite = "";
                });
                this.invite = invite;
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
                invite:"",
                currentEvent:null,
            }
        },
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        created () {
            var tab = [];
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