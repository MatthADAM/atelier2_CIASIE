<template>
    <div>
        <h4>{{event.name}}</h4>
        <div>
            <p>Adresse : {{event.adress}}, {{event.postCode}}</p>
            <p>Date et heure : {{event.date}}</p>
            <p>Personnes qui participent :</p>
            <li>
                <ul v-for="(item,index) in participants" :key="index"><b-icon-people></b-icon-people> - {{item}}</ul>
            </li>
            <p>Personnes qui ne participent pas :</p>
            <li>
                <ul v-for="(item,index) in nnParticipants" :key="index"><b-icon-people></b-icon-people> - {{item}}</ul>
            </li>
        </div>
    </div>
</template>

<script>
import $ from 'jquery'
    export default {
        created () {
            var event;
            $.ajax({
                url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/event?token=" + this.tokenInvite,
                success: function (result) {
                    event = result[0];
                    let annee = event.date.substr(0,4);
                    let mois = event.date.substr(5,2);
                    let jour = event.date.substr(8,2);
                    let heure = event.date.substr(11,2);
                    let minute = event.date.substr(14,2);
                    event.date = jour + "/" + mois + "/" + annee + " - " + heure + "H" + minute;
                },
                async: false
            });
            this.event = event;

            var part = [];
            var nnPart = [];
            $.ajax({
                url: "https://docketu.iutnc.univ-lorraine.fr:11501/api/invitation/" + event.id,
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
        methods: {
        },
        data () {
            return {
                event:null,
                participants:[],
                nnParticipants:[],
            }
        },
        computed: {
            tokenInvite() {return this.$route.params.tokenInvite},
        },
        
    }
</script>

<style>

</style>