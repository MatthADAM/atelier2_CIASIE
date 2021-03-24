<template>
    <div>
        <navbar></navbar>
        <p>Bienvenue {{this.$session.get("name")}} !</p>
        <div class="mapbox">
            <div v-if="loading">
                <spinner></spinner>
            </div>
            <div v-else>
                <l-map
                    :center="center"
                    :zoom="zoom"
                    class="map"
                    ref="map"
                    style="width:900px;height:400px;"
                    v-if="coord.length == markers.length">
                    <l-tile-layer :url="osmurl"></l-tile-layer>
                    <l-marker v-for="(item,index) in markers" :key="item.name" :lat-lng="coord[index]">
                        <l-popup :content="item.name + ' - ' + item.adress"></l-popup>
                    </l-marker>
                </l-map>
                <l-map :center="center"
                    :zoom="zoom"
                    class="map"
                    ref="map"
                    style="width:900px;height:400px;"
                    v-else>
                    <l-tile-layer :url="osmurl"></l-tile-layer>
                </l-map>
            </div>
        </div>
    </div>
</template>

<script>

import { LMap, LTileLayer, LMarker, LIcon, LPopup} from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';
import axios from 'axios';
import spinner from 'vue-spinner/src/SyncLoader';
import Navbar from './Navbar.vue';
import {urlApi} from '../variables/variables.js';
import $ from 'jquery'

    export default {
        beforeCreate: function () {
            if (!this.$session.exists()) {
            this.$router.push('/')
            }
        },
        methods: {
        },
        data () {
            return {
                center: [48.688418, 6.1825940],
                zoom: 12,
                osmurl: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                markers: [/* 
                    {id:1,name:"Test1", adress: "37 Rue du général frère", postCode:"54500",public:true,date:Date.now(),owner:{nom:"ADAM"}},
                    {id:2,name:"Test2", adress: "2Ter Boulevard Charlemagne", postCode:"54000",public:true,date:Date.now(),owner:{nom:"ADAM"}}, */
                ],
                lat:0,
                lon:0,
                coord:[],
                eventPublic: [],
                loading: true,
            }
        },
        created () {
            var tmp;
            this.markers.push("PUTE");
            $.ajax({
                url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1",
                success: function (result) {
                    // console.log(result);
                    tmp = result;
                    console.log(this.markers);
                    /* this.markers.forEach(element => {
                        console.log("A");
                        console.log(element);
                        if (element.public == 1) {
                            axios
                            .get("https://api-adresse.data.gouv.fr/search/?q=" + element.adress.replace(/ /g, "+") + "&postcode=" + element.postCode)
                            .then(response => {
                                this.lat = response.data.features[0].geometry.coordinates[1];
                                this.lon = response.data.features[0].geometry.coordinates[0];
                                this.coord.push([this.lat,this.lon]);
                                this.eventPublic.push(element);
                            });    
                        } else {
                            console.log("non");
                        }
                    }); */
                },
                async: false
            });
            this.markers = tmp;
            // $.ajax({
            //         url: "http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"),
            //         success: function (result) {
            //             // console.log(result);
            //             var temp = this.markers
            //             result.forEach(element => {
            //                 temp.push(element);
            //             });
            //             this.markers = temp;
            //         },
            //         async: false
            //     });
            /* axios
            .get("http://docketu.iutnc.univ-lorraine.fr:11501/api/event?public=1")
            .then(response => {
                this.markers = response.data;
            });
            axios
            .get("http://docketu.iutnc.univ-lorraine.fr:11501/api/event/owner/" + this.$session.get("log"))
            .then(response => {
                response.data.forEach(element => {
                    this.markers.push(element);
                });
            }); */
            console.log("B");
            console.log(this.markers);
            this.markers.forEach(element => {
                console.log("A");
                console.log(element);
                if (element.public == 1) {
                    axios
                    .get("https://api-adresse.data.gouv.fr/search/?q=" + element.adress.replace(/ /g, "+") + "&postcode=" + element.postCode)
                    .then(response => {
                        this.lat = response.data.features[0].geometry.coordinates[1];
                        this.lon = response.data.features[0].geometry.coordinates[0];
                        this.coord.push([this.lat,this.lon]);
                        this.eventPublic.push(element);
                    });    
                } else {
                    console.log("non");
                }
            });
            this.loading = false;
        },
        components: {LMap, LTileLayer, LMarker, LIcon, LPopup, spinner, Navbar},   
    }
</script>

<style>
*{
    background-color: inherit;
}

.icon {
    height:10rem;
    width:auto;
}
.mapbox {
    margin: auto;
    width: 900px;
    height: 400px;
}
</style>