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
                <th scope="col">Infos</th>
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
                <td>
                    <b-icon-trash style="margin-right:4px" class="clickable" @click="deleteEvent(item.id)"></b-icon-trash>
                    <b-icon-people style="margin-left:4px,margin-right:4px" class="clickable" v-b-modal.modalParticipants @click="voirParticipants(item.id)"></b-icon-people>
                    <b-icon-journal-bookmark-fill class="clickable" v-b-modal.modalCommentaires @click="voirCommentaires(item.id)"></b-icon-journal-bookmark-fill>
                    <b-icon-share-fill class="clickable" @click="copyUrl(item.token)"></b-icon-share-fill>
                </td>
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
        <b-modal ref="modalParticipants" id="modalParticipants" title="Liste des participants" hide-footer scrollable>
            <p>Personnes qui participent :</p>
            <li>
                <ul v-for="(item,index) in participants" :key="index"><b-icon-people></b-icon-people> - {{item}}</ul>
            </li>
            <p>Personnes qui ne participent pas :</p>
            <li>
                <ul v-for="(item,index) in nnParticipants" :key="index"><b-icon-people></b-icon-people> - {{item}}</ul>
            </li>
        </b-modal>
        <b-modal ref="modalCommentaires" id="modalCommentaires" title="Espace commentaires" size="lg" hide-footer>
            <div style="overflow:scroll; height:400px">
                <li>
                    <ul v-for="(comm,index) in commentaires" :key="index">{{comm.name}} le {{comm.date}} : {{comm.content}}</ul>
                </li>
            </div>
            <input type="text" class="form-control" v-model="comment" placeholder="Tapez votre commentaire" v-on:keyup.enter="ajouterCommentaire(idEventComm)">
            <button @click="ajouterCommentaire(idEventComm)" class="btn btn-primary">Ajouter commentaire</button>
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
                axios.post('https://docketu.iutnc.univ-lorraine.fr:11501/api/delete/event/' + id)
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
                axios.post('https://docketu.iutnc.univ-lorraine.fr:11501/api/addInvitation', {
                    event: this.currentEvent,
                    user: this.invite,
                })
                .then(function (response) {
                    rf.hide();
                    invite = "";
                });
                this.invite = invite;
            },
            voirParticipants(event) {
                var part = [];
                var nnPart = [];
                $.ajax({
                    url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/invitation/" + event,
                    success: function (result) {
                        result.forEach(element => {
                            if (element.status == 1) {   
                                $.ajax({
                                    url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + element.user,
                                    success: function (result) {
                                        result.forEach(usr => {
                                            part.push(usr.Name);
                                        });
                                    },
                                    async: false
                                });
                            } else if (element.status == 2) {
                                $.ajax({
                                    url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + element.user,
                                    success: function (result) {
                                        result.forEach(usr => {
                                            nnPart.push(usr.Name);
                                        });
                                    },
                                    async: false
                                });
                            }
                        });
                    },
                    async: false
                });
                this.participants = part;
                this.nnParticipants = nnPart;
            },
            voirCommentaires(event) {
                var comm = [];
                var own;
                this.idEventComm = event;
                $.ajax({
                    url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/comment/event/" + event,
                    success: function (result) {
                        result.forEach(element => {
                            $.ajax({
                                url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + element.owner,
                                success: function (result) {
                                    own = result[0].Name;
                                },
                                async: false
                            });
                            Object.defineProperty(element,"name", {value: own});
                            let annee = element.date.substr(0,4);
                            let mois = element.date.substr(5,2);
                            let jour = element.date.substr(8,2);
                            let heure = element.date.substr(11,2);
                            let minute = element.date.substr(14,2);
                            element.date = jour + "/" + mois + "/" + annee + " - " + heure + "H" + minute;
                            comm.push(element);
                        });
                    },
                    async: false
                });
                this.commentaires = comm;
            },
            ajouterCommentaire(event) {
                var comm = [];
                var own;
                axios.post('https://docketu.iutnc.univ-lorraine.fr:11501/api/addComment', {
                    content:this.comment,
                    owner:this.$session.get('log'),
                    event:event,
                })
                .then(function (response) {
                    $.ajax({
                        url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/comment/event/" + event,
                        success: function (result) {
                            result.forEach(element => {
                                $.ajax({
                                    url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/user/" + element.owner,
                                    success: function (result) {
                                        own = result[0].Name;
                                    },
                                    async: false
                                });
                                Object.defineProperty(element,"name", {value: own});
                                let annee = element.date.substr(0,4);
                                let mois = element.date.substr(5,2);
                                let jour = element.date.substr(8,2);
                                let heure = element.date.substr(11,2);
                                let minute = element.date.substr(14,2);
                                element.date = jour + "/" + mois + "/" + annee + " - " + heure + "H" + minute;
                                comm.push(element);
                            });
                        },
                        async: false
                    });
                });
                this.commentaires = comm;
                this.comment="";
            },
            copyUrl(event) {
                navigator.clipboard.writeText("http://localhost:8080/eventIvite/" + event);
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
                participants: [],
                nnParticipants:[],
                commentaires: [],
                idEventComm:null,
                comment:"",
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
                url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"),
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
                element.date = jour + "/" + mois + "/" + annee + " - " + heure + "H" + minute;
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